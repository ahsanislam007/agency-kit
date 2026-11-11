---
name: agency-playwright-testing
description: >
  Agency-global Playwright web E2E skill. Use when writing, reviewing, or
  debugging Playwright specs; getByRole / getByTestId selectors; fixtures;
  storageState auth; flaky waits; traces; webServer config; CI; or Playwright
  MCP write-run-fix loops. Prefer this for spec authoring on any web git repo.
  Pair with agency-web-test-setup for scaffolding and the Playwright MCP for
  live agent browser control. Skip for native mobile Maestro / unit-test-only.
disable-model-invocation: false
---

# Agency Playwright testing (web)

**Agency kit skill** — installed for every agent at `~/.agents/skills/agency-playwright-testing`.

Canonical docs: [playwright.dev](https://playwright.dev) · MCP: [getting-started-mcp](https://playwright.dev/docs/getting-started-mcp).

## Agency wiring (read first)

| Layer | Skill / tool |
|-------|----------------|
| Scaffold `e2e/` + CI + MCP pointer | `agency-web-test-setup` |
| Author / debug specs | **this skill** (`agency-playwright-testing`) |
| Live browser / accessibility snapshots | Playwright MCP — **`user-playwright`** in Cursor, `mcp__playwright__*` in Claude Code |

1. Route substantive repo work via `agency-project-gateway`.
2. Discover **this** app’s `baseURL` / package manager — never copy another project’s URLs.
3. Prefer Playwright MCP for exploratory agent loops; prefer `npx playwright test` for deterministic CI smoke.
4. Do **not** default to `cursor-ide-browser` when Playwright MCP is connected. Use IDE browser only if Playwright MCP is missing/broken (then fix MCP).

## Workflow

1. Identify stack (Next/Vite/etc.), `baseURL`, existing `playwright.config.*` / `e2e/`, and auth needs.
2. Prefer one smoke + one critical path per ask. Do not invent a full suite.
3. Choose selectors with the policy below; add `data-testid` in app code when roles/labels are unstable.
4. Wait for **state** (`expect(...).toBeVisible()`, network idle only when justified) — never fixed `sleep`.
5. On failure: open trace (`npx playwright show-trace`) or re-run headed / `--ui`; fix root cause once.
6. When MCP is available: navigate → snapshot → act → assert → optionally generate/adjust a spec.

## Selector policy

Prefer, in order:

1. `getByRole(...)` with accessible name
2. `getByLabel` / `getByPlaceholder` for forms
3. `getByTestId(...)` for dynamic/repeated/icon-only UI (`data-testid`)
4. `getByText` only for intentional copy assertions
5. CSS/XPath last resort — document why

Avoid brittle class/nth-child chains. For lists, scope with a stable parent + role/testid per row.

```ts
await page.getByRole("button", { name: "Sign in" }).click();
await page.getByTestId("dashboard.loaded").waitFor();
await expect(page.getByRole("heading", { name: "Dashboard" })).toBeVisible();
```

## Auth & state

- First green path: unauthenticated smoke.
- Logged-in flows: `storageState` from a setup project (see Playwright auth docs) — one setup, many specs.
- Never commit real passwords. Use env / MCP `--secrets` patterns; redact fixtures in PRs.
- Prefer project-isolated storage; do not reuse production cookies in CI.

## Flake control

- Assert UI readiness markers (`*.loaded` test ids) instead of arbitrary timeouts.
- Use `expect.poll` / web-first assertions; avoid manual `waitForTimeout`.
- CI: `retries: 2`, `workers: 1` for smoke; traces `on-first-retry`.
- Stub/mock only unstable third parties; prefer real local app via `webServer`.

## MCP loop (agent QA)

1. Confirm Playwright MCP connected (`user-playwright`).
2. Navigate to the target URL.
3. Use accessibility snapshot refs for clicks/fills (not pixel guessing).
4. Screenshot only when visual confirmation helps.
5. When the path is stable, write/update a Playwright Test spec under `e2e/` so CI owns the regression.

Complex one-offs may use MCP code-execution tools only on trusted local targets — prefer ordinary tool calls + committed specs for anything that should stay green.

## CI

- Separate workflow from deploy (see `agency-web-test-setup` / `reference.md`).
- Chromium-only by default.
- Upload `playwright-report/` + `test-results/` on failure/always.

## Anti-patterns

- Page Object Industrial Complex for 1–2 specs
- Multi-browser matrix before one chromium smoke is green
- Hardcoded sleeps / production credentials in repo
- Replacing unit tests with E2E
- Silent global installs

## Companion

- Scaffolding: `agency-web-test-setup`
- Mobile native: `agency-mobile-test-setup` + `agency-maestro-testing` (not this skill)
