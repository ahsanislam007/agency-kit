---
name: agency-project-gateway
description: >
  PRIME agency orchestrator skill. Use FIRST for ANY substantive git-repo agency
  work (feature build, UI/UX/design, brand, Figma, web/mobile/KMP, backend,
  cloud, architecture, DevOps, QA, docs, PM, research, growth, revenue, sales,
  CS, finance, data, AI/automation). Triage, context packet, Lazyweb→Stitch for
  UI, then spawn agency-* specialists via Task. Do NOT use for home/no-repo or
  trivial Q&A. Prefer launching the agency-project-gateway subagent; this skill
  is the checklist if you must orchestrate inline.
disable-model-invocation: false
---

# Agency project gateway (prime)

You are the **mandatory first hop**. Do not hand work to other `agency-*` agents until this checklist is done.

## When to run

**Always** on substantive git-repo work that maps to the agency team (see description).

**Skip** for home / empty-window / no git repo / trivial Q&A.

## Procedure

1. Confirm git repo + project root → `move_agent_to_root` if needed.
2. Prefer launching the `agency-project-gateway` subagent (`Task`) — it owns the full run. Agents without subagents (Codex, Gemini CLI, …) run this checklist inline.
3. If orchestrating inline: read `agency-context-packet`, fill Goal / Done-when / paths.
4. Product UI? Follow `agency-ui-pipeline` + `agency-rich-ui` before design/build agents. For **React/Tailwind/shadcn implement**, also load `agency-21st` (21st MCP catalog supply after design).
5. **Architecture / sequence / workflow / data-flow / lifecycle map?** Run `agency-archify` before `agency-cto-architect` / `agency-docs-writer`; fill packet `Archify:` line.
6. **New app / bootstrap / KMP modularization / MVVM-MVI / Gradle convention plugins?** Load `agency-app-architecture` before CTO / `agency-build-governance` / KMP / Android agents. Packet lists module tree, plugin ids, MVI types.
7. **Mobile testing / agentic E2E / Maestro / agent-device / UI automation setup?** Load `agency-mobile-test-setup` (default = Maestro CI smoke + agent-device local QA). For native Maestro **flow authoring**, also load `agency-maestro-testing`. Discover appId per repo; do not copy another project’s package names. Prefer the Maestro MCP for live runs.
7b. **Web testing / Playwright / agentic browser E2E / web smoke/CI setup?** Load `agency-web-test-setup` (default = Playwright Test CI smoke + Playwright MCP local QA). For **spec authoring**, also load `agency-playwright-testing`. Discover baseURL / package manager per repo; chromium-only smoke by default. Prefer the Playwright MCP for live agent loops; do not default to `cursor-ide-browser` when Playwright MCP is available.
8. **Design QA / Figma vs app / visual audit / UI test report?** Load `agency-design-qa-report` (one HTML report). App findings → platform engineer; Data / Design / Blocked items → their owners.
9. **Reverse engineering / shipped artifacts (binary, APK/IPA, Electron/JS, firmware, AgentEnv)?** Load `agency-reverse-engineer-anything` (REA). For Android static jadx/API extraction scripts, also load `agency-android-reverse-engineering`. Authorized targets only; packet `REA:` / `AndroidRE:` lines. Pair findings with `agency-qa-security`.
10. **Authorized autonomous pentest / PentAGI / red-team agent stack?** Load `agency-pentagi`. Require packet `PentAGI:` Scope line (target + permission). Runtime at `$PENTAGI_HOME` (default `$HOME/Projects/pentagi`). Pair findings with `agency-qa-security`. Do not use for static RE or Maestro.
11. **Live web / YouTube / GitHub / RSS / open-web search (not Lazyweb UI screens)?** Load `agency-agent-reach`; fill packet `AgentReach:` line. Prefer zero-config channels; optional social only if user asked.
12. **User-facing feature add/change?** After build, load side skill `agency-feature-docs` (README + user guide how-to + screenshots). Fill packet `FeatureDocs:` line. Skip only if user said code-only / skip docs.
13. **Compound Engineering (optional strengthen)?** Load `agency-compound-engineering`. After packet fill: unsettled shape → `/ce-brainstorm`; multi-step impl → `/ce-plan` (plan path in packet); after ship → `/ce-compound`. CE does **not** replace gateway, Lazyweb→Stitch, or Task spawn. Fill packet `CE:` line when used.
14. Apply `agency-token-budget`.
15. Spawn specialists with the **same** packet in every Task prompt.
16. Multi-lane → `agency-chief-of-staff` after packet (+ UI fields if UI).

## Spawn map (short)

- UI/design → `agency-ui-ux-designer` (+ brand/Figma agents as needed) → platform engineer
- **React web implement (catalog)** → `agency-21st` + 21st MCP → `agency-frontend-web-engineer`
- **Web craft extras (GSAP / transitions.dev / designlang / taste / React Bits)** → load `agency-web-craft` (+ `agency-designlang` when extracting a URL); free tiers only unless user opts into paid
- **New app scaffold** → `agency-app-architecture` skill → `agency-cto-architect` + `agency-build-governance` → `agency-kmp-engineer` / `agency-android-developer`
- Feature impl → platform engineer (`frontend-web` / `android` / `ios` / `kmp` / `project-engineer`) → then **`agency-feature-docs`** side skill (README + user guide + screenshots)
- API/cloud → `agency-backend-engineer` / `agency-backend-cloud`
- Architecture → `agency-archify` map (when a diagram is in scope) → `agency-cto-architect`
- **Design QA** → `agency-design-qa-report` → platform engineer for App fixes / `agency-qa-security`
- **Mobile test setup** → `agency-mobile-test-setup` + `agency-maestro-testing` (flows) → inline implement (or `agency-qa-security` + `agency-devops-sre` + `agency-automation-ai-integrations` if multi-lane)
- **Web Playwright setup** → `agency-web-test-setup` + `agency-playwright-testing` (specs) → inline implement (or `agency-qa-security` + `agency-devops-sre` + `agency-automation-ai-integrations` if multi-lane)
- **Reverse engineering** → `agency-reverse-engineer-anything` (REA) + optional `agency-android-reverse-engineering` (jadx/API) → `agency-qa-security` for findings
- **Authorized pentest / PentAGI** → `agency-pentagi` → `agency-qa-security` for findings
- **Feature docs (side)** → `agency-feature-docs` after any user-facing feature; prefer inline, else `agency-docs-writer`
- Ship/QA → `agency-devops-sre` / `agency-qa-security` / `agency-docs-writer`
- Growth/biz → marketing / revenue / sales / CS / data / finance agents
- Live URL/video/repo/web research → `agency-agent-reach` (engine: `agent-reach`)
- **CE strengthen** → `agency-compound-engineering` (plugin `ce-*` / `/lfg`); never port CE bodies into agency-*

Never use `agency-u-ux-designer`; use `agency-ui-ux-designer`.

## Anti-patterns

- Calling a specialist before gateway triage
- Empty Goal/Done-when with a multi-agent swarm
- Skipping Lazyweb→Stitch on product UI
- Skipping `agency-21st` / 21st MCP on React/Tailwind/shadcn catalog implement (hand-rolling when search fits)
- Skipping `agency-app-architecture` on new Android/KMP app bootstrap
- Hand-drawing Mermaid for an architecture/flow map instead of `agency-archify`
- Skipping `agency-mobile-test-setup` on mobile Maestro/agent-device/E2E setup asks
- Skipping `agency-web-test-setup` on web Playwright / browser E2E setup asks
- Skipping `agency-reverse-engineer-anything` on shipped-artifact RE asks (or `agency-android-reverse-engineering` for Android jadx/API extraction)
- Skipping `agency-pentagi` on authorized autonomous pentest / PentAGI asks (or running scans without a Scope permission line)
- Skipping `agency-agent-reach` when the ask needs live web/social/video evidence outside Lazyweb
- Shipping a user-facing feature without `agency-feature-docs` (unless user said skip docs)
- Letting CE `/ce-work` or `/lfg` bypass gateway on agency-team work
- Rebuilding packets per specialist
- Hardcoding another app’s `applicationId` / package name into a different repo

## Portability (Claude Code, Codex, Gemini, …)

Tool names above are Cursor's. Elsewhere: `move_agent_to_root` → open or `cd` into the repo;
`Task` → that agent's subagent tool (Claude Code subagents cannot start subagents, so the
gateway subagent returns packet + specialist list and the parent launches them); MCP
`user-<server>` → `mcp__<server>__<tool>` in Claude Code. Every agency skill is installed at
`~/.agents/skills/<name>/SKILL.md`.
