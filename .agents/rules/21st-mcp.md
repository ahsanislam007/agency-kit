---
description: Require the 21st.dev MCP for React/Tailwind/shadcn component catalog work across every project
alwaysApply: true
---

# 21st MCP — all projects (React supply)

The 21st MCP is configured **globally** as server `21st` and must be available in every workspace for React/Tailwind/shadcn (and Expo when asked) UI implement work. Formerly Magic MCP (`@21st-dev/magic` still aliases).

| Agent | Config | Tool names |
|---|---|---|
| Cursor | `~/.cursor/mcp.json` | namespace `user-21st` |
| Claude Code | user scope (`claude mcp list`) | `mcp__21st__*` |

## Agents MUST

1. Prefer 21st MCP tools (`search`, `get_component`, `get_inspiration`, `search_logo`, `get_usage`, …) over inventing React components from scratch when a catalog match exists.
2. Keep **design** on `agency-ui-pipeline` (Lazyweb → Stitch). 21st is the **implement** supply layer for React — load **`agency-21st`** (and upstream `21st-cli-use` / `21st-ui-build` as needed).
3. Check `get_usage` / `aiGenerationEnabled` before hosted `generate`. If AI is off, search → retrieve → adapt locally.
4. If the 21st MCP is missing / `error` / needs auth: set `x-api-key` from https://21st.dev/mcp (`API_KEY_21ST` / `TWENTYFIRST_TOKEN`). Cursor: `~/.cursor/mcp.json`. Claude Code: `claude mcp add -s user --transport http 21st https://21st.dev/api/mcp -H "x-api-key: …"`. Ask the user to reload MCPs — do not silently skip 21st on React web implement asks.

## Scope

Applies to React / Next / Vite + Tailwind / shadcn web UI implement (and Expo/RN when the user says so). Skip for native Android/iOS/KMP Compose/SwiftUI, backend-only, or non-UI work.
