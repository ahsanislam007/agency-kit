---
name: agency-mobile-test-setup
description: >
  Portable dual mobile test setup: Maestro (deterministic CI smoke) + Callstack
  agent-device (local agent QA in Cursor / Claude Code). Use when the user asks for testing setup,
  agentic testing, E2E, UI automation, Maestro, agent-device, device QA, or
  mobile smoke/CI tests on any Android/iOS/KMP/RN mobile git repo. Default is
  BOTH layers unless they pick one. Do NOT use for unit-test-only asks, web-only
  Playwright (use agency-web-test-setup), or non-mobile projects.
disable-model-invocation: false
---

# Agency mobile test setup (Maestro + agent-device)

Canonical dual stack for **any** mobile app repo. Typical layout to recreate
per project: `maestro/`, `.github/workflows/maestro-smoke.yml`, project MCP
config + agent-device rule, and a short `docs/agent-device.md` runbook.

## Repo gate

**Activate** only inside a **git** mobile project (Android / iOS / KMP / RN).  
**Skip** home / empty-window / web-only.

## Default offer

When the user asks for testing / agentic / E2E / automation setup and does not pick:

1. **agent-device** only (local agent QA)
2. **Maestro** only (CI smoke)
3. **Both** ← **default**

If they already said “both” / “3” / “full”, implement without re-asking.

## Procedure (after `agency-project-gateway` triage)

1. `move_agent_to_root` to the target repo.
2. Orient: graphify (if present) or narrow grep — discover **appId / bundleId**, debug assemble task, existing CI.
3. Fill context packet (`agency-context-packet`): Goal = dual smoke+agent QA; Done-when = files below + documented run commands; Non-goals = full suite / rewrite unit tests.
4. Prefer **inline parent implement** (cheap). Spawn `agency-qa-security` / `agency-devops-sre` / `agency-automation-ai-integrations` only if multi-lane.
5. Create files from templates in `reference.md` — **substitute project-specific IDs**; never copy another app’s package names blindly.
6. Do **not** hang Maestro on Play Store / App Store deploy workflows — add a **separate** GHA (or doc equivalent for other CI).
7. Do **not** `npm install -g` without user approval; document install commands and ask them to run (or use smart-mode approval).
8. After code edits: `graphify update .` if graphify-out exists.
9. Do not commit unless asked.

## Discover (per project)

| Need | How |
|------|-----|
| Android `appId` | `applicationId` + flavor `applicationIdSuffix` (prefer staging/debug/dev) |
| Assemble task | e.g. `:app:assembleDebug`, `:classmate:assembleStagingDebug` |
| APK path | `**/build/outputs/apk/**/*.apk` after assemble |
| Launch assert text | First stable unauthenticated string (Login / Sign in / app name) — launch-only if unknown |
| Existing CI | List `.github/workflows/*` — never bolt onto store-upload jobs |
| iOS bundle id | Xcode / `PRODUCT_BUNDLE_IDENTIFIER` (agent-device; Maestro optional) |

## Files to create/edit (every Android/KMP app)

| Path | Purpose |
|------|---------|
| `maestro/smoke_launch.yaml` | Launch-only smoke with **discovered** `appId` |
| `maestro/README.md` | Local + CI how-to (short) |
| `.github/workflows/maestro-smoke.yml` | Emulator + Maestro; **separate** from deploy |
| `.cursor/mcp.json` (Cursor) / `.mcp.json` (Claude Code) | Merge `agent-device` → `agent-device mcp` (keep existing servers) |
| Agent rule: `.agents/rules/agent-device.md` + kit sync if the repo has an `.agents/` kit, else `.cursor/rules/agent-device.mdc` (+ `.claude/rules/agent-device.md`) | Callstack recommended rule + **this app’s** default appId/platform |
| `docs/agent-device.md` | Install, doctor, open/snapshot loop for **this** appId |
| `Agent.md` / `AGENTS.md` / README § testing | 3–5 lines pointing at Maestro + agent-device |

Optional later: more Maestro flows once selectors/credentials exist.

## Done when

- [ ] Maestro smoke exists and documents local run
- [ ] Separate CI workflow (or explicit “manual-only” note if no GHA)
- [ ] agent-device MCP + agent rule + short docs with **this** app’s id
- [ ] User told one-time CLI installs: Maestro curl + `npm install -g agent-device@latest`
- [ ] Minimal diffs; no unrelated refactors

## Anti-patterns

- Hardcoding another project’s `applicationId`
- Putting Maestro into Play/App Store release jobs
- Replacing unit/`androidTest` with agent-device
- Full regression suite on day one
- Silent `npx -y agent-device@latest` for MCP
- Skipping gateway on substantive repo setup

## Companion skill

- **Flow authoring (native YAML / selectors):** `agency-maestro-testing`
- **Live runs:** Maestro MCP (`user-maestro` in Cursor, `mcp__maestro__*` in Claude Code)
- **Web Playwright (not this skill):** `agency-web-test-setup` + `agency-playwright-testing`
- This skill stays focused on **scaffolding** (smoke + CI + agent-device wiring).

## Refs

- Templates: same skill folder `reference.md`
- agent-device setup: https://oss.callstack.com/agent-device/docs/agent-setup
- Maestro install: https://docs.maestro.dev/maestro-cli/how-to-install-maestro-cli
