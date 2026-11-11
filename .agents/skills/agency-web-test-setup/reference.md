# Templates (substitute per project)

Placeholders:

- `{{BASE_URL}}` — e.g. `http://127.0.0.1:3000`
- `{{WEB_SERVER_CMD}}` — e.g. `pnpm run dev` / `npm run start`
- `{{WEB_SERVER_URL}}` — usually same as `{{BASE_URL}}`
- `{{SMOKE_PATH}}` — path under test, e.g. `/` or `/login`
- `{{SMOKE_VISIBLE}}` — stable role/name or text, e.g. brand / “Sign in”
- `{{PR_PATHS}}` — YAML list of path filters for the PR trigger
- `{{PKG}}` — `pnpm` / `npm` / `yarn` / `bun`
- `{{LOCKFILE}}` — lockfile name for cache action

---

## `playwright.config.ts`

```ts
import { defineConfig, devices } from "@playwright/test";

export default defineConfig({
  testDir: "e2e",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: process.env.CI ? "github" : "list",
  use: {
    baseURL: process.env.PLAYWRIGHT_BASE_URL ?? "{{BASE_URL}}",
    trace: "on-first-retry",
  },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"] } }],
  // Drop webServer if the app is already running / externally hosted.
  webServer: {
    command: "{{WEB_SERVER_CMD}}",
    url: "{{WEB_SERVER_URL}}",
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
  },
});
```

---

## `e2e/smoke.spec.ts`

```ts
import { test, expect } from "@playwright/test";

test("home loads", async ({ page }) => {
  await page.goto("{{SMOKE_PATH}}");
  await expect(page.getByRole("heading", { name: "{{SMOKE_VISIBLE}}" })).toBeVisible();
});
```

Prefer `getByRole` / `getByTestId`. If copy is unstable, use a test id and document the app change:

```ts
await expect(page.getByTestId("home.loaded")).toBeVisible();
```

---

## `e2e/README.md` (sketch)

```markdown
# Playwright (CI smoke)

baseURL: `{{BASE_URL}}`

## Local

{{PKG}} add -D @playwright/test
npx playwright install chromium
{{PKG}} exec playwright test
{{PKG}} exec playwright test --ui

## CI

`.github/workflows/playwright-smoke.yml` — separate from deploy.

Agentic / exploratory QA → global Playwright MCP (`user-playwright`), not a new spec for every check.
Authoring help → skill `agency-playwright-testing`.
```

---

## `package.json` scripts (merge)

```json
{
  "scripts": {
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:e2e:headed": "playwright test --headed"
  },
  "devDependencies": {
    "@playwright/test": "latest"
  }
}
```

Pin a real version at install time — do not leave `"latest"` in committed lockfiles.

---

## `.github/workflows/playwright-smoke.yml`

```yaml
name: Playwright smoke

on:
  workflow_dispatch:
  pull_request:
    paths:
{{PR_PATHS}}

permissions:
  contents: read

concurrency:
  group: playwright-smoke-${{ github.ref }}
  cancel-in-progress: true

jobs:
  smoke:
    name: chromium smoke
    runs-on: ubuntu-latest
    timeout-minutes: 30
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "22"
          cache: "{{PKG}}"
          cache-dependency-path: "{{LOCKFILE}}"
      - name: Install deps
        run: |
          if [ "{{PKG}}" = "pnpm" ]; then corepack enable && pnpm install --frozen-lockfile
          elif [ "{{PKG}}" = "yarn" ]; then yarn install --frozen-lockfile
          elif [ "{{PKG}}" = "bun" ]; then bun install --frozen-lockfile
          else npm ci
          fi
      - name: Install Playwright Chromium
        run: npx playwright install chromium --with-deps
      - name: Run smoke
        run: npx playwright test
        env:
          CI: true
      - if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: |
            playwright-report/
            test-results/
          retention-days: 7
```

Adjust install step to the repo’s real package manager; keep **chromium-only**.

---

## Global Playwright MCP (Cursor `~/.cursor/mcp.json`)

Already managed by the `playwright-mcp` Cursor rule. Standard entry:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

Claude Code: `claude mcp add -s user playwright npx @playwright/mcp@latest`

Optional: `--headless`, `--browser=chrome`, `--isolated`, `--idle-timeout=300000`.

---

## README / AGENTS.md blurb

```markdown
## Web E2E

- CI smoke: `e2e/` + `npx playwright test` (see `e2e/README.md`)
- Agentic browser QA: Playwright MCP (`user-playwright`) — skill `agency-playwright-testing`
- Scaffolding: skill `agency-web-test-setup`
```
