---
name: agency-web-test-setup
description: >
  Portable web E2E setup: Playwright (deterministic CI smoke) + Playwright MCP
  (local agent QA). Use when the user asks for web testing setup, agentic
  browser QA, Playwright install, e2e/smoke, or web UI automation on any web
  git repo (Next.js, React, Vite, static, etc.). Default is BOTH layers unless
  they pick one. Do NOT use for unit-test-only asks, native mobile Maestro, or
  non-web projects.
disable-model-invocation: false
---

# Agency web test setup (Playwright + MCP)

Canonical dual stack for **any** web app repo. Docs: [playwright.dev](https://playwright.dev) · MCP: [getting-started-mcp](https://playwright.dev/docs/getting-started-mcp).

## Repo gate

**Activate** only inside a **git** web project.  
**Skip** home / empty-window / native-mobile-only (use `agency-mobile-test-setup`).

## Default offer

When the user asks for testing / agentic / E2E / automation setup and does not pick:

1. **Playwright MCP** only (local agent QA)
2. **Playwright Test** only (CI smoke)
3. **Both** ← **default**

If they already said “both” / “3” / “full”, implement without re-asking.

## Procedure (after `agency-project-gateway` triage)

1. `move_agent_to_root` to the target repo.
2. Orient: graphify (if present) or narrow grep — discover **package manager**, **dev/start script**, **baseURL**, existing CI.
3. Fill context packet (`agency-context-packet`): Goal = dual smoke+agent QA; Done-when = files below + documented run commands; Non-goals = full suite / page-object framework / multi-browser matrix.
4. Prefer **inline parent implement** (cheap). Spawn `agency-qa-security` / `agency-devops-sre` / `agency-automation-ai-integrations` only if multi-lane.
5. Create files from templates in `reference.md` — **substitute project-specific baseURL / paths**; never copy another product’s URLs.
6. Do **not** hang Playwright on deploy/release workflows — add a **separate** GHA (or doc equivalent).
7. Do **not** silently `npm install` / browser download without user approval; document one-time commands and ask them to run (or use smart-mode approval).
8. Default CI browser = **chromium only**. Add firefox/webkit only when asked.
9. TypeScript-first (`@playwright/test`). Python/.NET/Java only if the repo already uses them.
10. After code edits: `graphify update .` if graphify-out exists.
11. Do not commit unless asked.

## Discover (per project)

| Need | How |
|------|-----|
| Package manager | `pnpm-lock.yaml` / `yarn.lock` / `package-lock.json` / `bun.lock*` |
| Dev / preview URL | `package.json` scripts (`dev`, `start`, `preview`) + env |
| `baseURL` | Local default `http://127.0.0.1:3000` (or Vite 5173) unless repo docs say otherwise |
| Existing Playwright | `playwright.config.*`, `e2e/`, `tests/`, `playwright/` |
| Existing CI | List `.github/workflows/*` — never bolt onto deploy/upload jobs |
| Auth | Prefer storageState fixture later; launch-only smoke first if auth unknown |

## Files to create/edit (every web app)

| Path | Purpose |
|------|---------|
| `playwright.config.ts` | Chromium project, `baseURL`, `webServer` when applicable |
| `e2e/smoke.spec.ts` | Launch/home smoke (or `tests/` if repo already uses it) |
| `e2e/README.md` | Local + CI how-to (short) |
| `.github/workflows/playwright-smoke.yml` | Install browsers + run smoke; **separate** from deploy |
| Root `package.json` | `devDependency` `@playwright/test` + scripts `test:e2e` / `test:e2e:ui` |
| `Agent.md` / `AGENTS.md` / README § testing | 3–5 lines pointing at Playwright + Playwright MCP |

Global (not per-repo): Playwright MCP in `~/.cursor/mcp.json` — see `playwright-mcp` Cursor rule. Do **not** require a project-level MCP copy.

Optional later: auth storageState, more specs, trace-on-retry once smoke is green.

## Done when

- [ ] Playwright smoke exists and documents local run
- [ ] Separate CI workflow (or explicit “manual-only” note if no GHA)
- [ ] Global Playwright MCP called out; user told to reload MCPs if newly added
- [ ] User told one-time installs: `npm/pnpm/yarn add -D @playwright/test` + `npx playwright install --with-deps` (chromium sufficient for smoke)
- [ ] Minimal diffs; no unrelated refactors

## Anti-patterns

- Hardcoding another project’s `baseURL` or auth fixtures
- Putting Playwright into production deploy jobs
- Full regression / visual / multi-browser matrix on day one
- Silent browser downloads without documenting one-time setup
- Using `cursor-ide-browser` as the default E2E stack when Playwright MCP is available
- Skipping gateway on substantive repo setup

## Companion skill

- **Spec authoring (selectors / fixtures / flaky waits):** `agency-playwright-testing`
- **Live agent loops:** Playwright MCP (`user-playwright` in Cursor, `mcp__playwright__*` in Claude Code)
- This skill stays focused on **scaffolding** (config + smoke + CI + MCP pointer).

## Refs

- Templates: same skill folder `reference.md`
- Install: https://playwright.dev/docs/intro
- MCP: https://playwright.dev/docs/getting-started-mcp
- CI: https://playwright.dev/docs/ci-intro
