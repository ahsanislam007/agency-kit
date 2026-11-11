---
description: Require the Maestro MCP for mobile UI/E2E across every project
alwaysApply: true
---

# Maestro MCP — all projects

The Maestro MCP is configured **globally** as server `maestro` and must be available in every workspace:

| Agent | Config | Tool names |
|---|---|---|
| Cursor | `~/.cursor/mcp.json` | namespace `user-maestro` |
| Claude Code | user scope (`claude mcp list`) | `mcp__maestro__*` |

## Agents MUST

1. Prefer the Maestro MCP tools (`list_devices`, `inspect_screen`, `take_screenshot`, `run`, `cheat_sheet`, `open_maestro_viewer`) for mobile UI automation, E2E, smoke, and on-device validation — do not invent ad-hoc shell-only Maestro flows when the MCP is ready.
2. Before first device interaction in a session, call `list_devices` (and surface Maestro Viewer if the tool returns a viewer URL).
3. For new/changed mobile app repos that need testing setup, follow `agency-mobile-test-setup` (smoke YAML + CI). For writing/debugging native Maestro YAML flows, load **`agency-maestro-testing`**. Global MCP alone does not replace per-repo `maestro/` smoke files.
4. If the Maestro MCP is missing / `error` / not connected: fix the global entry (command `$HOME/.maestro/bin/maestro` (or `$MAESTRO_BIN`), args `["mcp"]`, `JAVA_HOME` → JBR 17). Cursor: edit `~/.cursor/mcp.json`. Claude Code: `claude mcp add -s user maestro -e JAVA_HOME=<jbr17> -- "$HOME/.maestro/bin/maestro" mcp`. Then ask the user to reload MCPs — do not silently skip Maestro.

## Scope

Applies to Android / iOS / KMP / RN / Flutter mobile work. Skip for pure web (unless user asks Maestro Chromium), backend-only, or unit-test-only asks.
