---
description: When user asks for mobile testing / agentic E2E / Maestro / agent-device setup on any app repo, use agency-mobile-test-setup (dual stack by default)
alwaysApply: true
---

# Agency mobile test setup (cross-project)

When the user asks for **testing setup**, **agentic testing**, **E2E**, **UI automation**, **Maestro**, **agent-device**, or **mobile smoke/CI tests** inside a **mobile** git repo (Android / iOS / KMP / RN):

1. Route via `agency-project-gateway` first (same as other agency work).
2. Load and follow skill **`agency-mobile-test-setup`** (`~/.agents/skills/agency-mobile-test-setup/SKILL.md` + `reference.md` templates).
3. **Default = both**: Maestro (deterministic CI smoke) + Callstack agent-device (local agent QA), unless the user picks one.
4. **Discover** this repo’s `applicationId` / bundle id, assemble task, and CI — never copy another app’s package names.
5. Keep Maestro off store-deploy workflows; add a separate job/workflow.
6. Document one-time CLI installs; do not silently global-install packages without approval.
7. **Maestro MCP is global** (Cursor: `~/.cursor/mcp.json` → `user-maestro`; Claude Code: user-scope `maestro` → `mcp__maestro__*`). Use it in every mobile project; do not rely only on a project-level MCP entry.

Skip for unit-test-only asks, web Playwright-only (use `agency-web-test-setup`), or non-mobile workspaces.

8. For Maestro **flow authoring** (YAML, selectors, Compose tags), load **`agency-maestro-testing`** in addition to this setup skill.
