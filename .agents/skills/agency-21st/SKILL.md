---
name: agency-21st
description: >
  Agency SOP for the 21st.dev MCP + CLI (React/Tailwind/shadcn component catalog,
  formerly Magic MCP). Use when implementing web UI from catalog components,
  searching/installing 21st components, logos, themes, or 21st AI sketches —
  after Lazyweb→Stitch design when the stack is React. Prefer MCP tools over
  ad-hoc copy-paste. Skip for native Android/iOS/KMP Compose/SwiftUI (unless
  Expo/RN and user asks), backend/CLI-only, or when packet already has 21st
  fields filled for this workstream.
disable-model-invocation: false
---

# Agency 21st (catalog + MCP)

**Agency kit skill** — installed for every agent at `~/.agents/skills/agency-21st`.

Upstream engine skills (also installed): `21st-cli-use`, `21st-ui-build`,
`21st-ui-explore`, `21st-ui-review`, `21st-ai`, `21st-registry`,
`21st-design-sync`, `21st-video`. Docs: https://21st.dev/mcp · https://21st.dev/llms.txt

## Agency wiring (read first)

| Layer | Skill / tool |
|-------|----------------|
| Design research → screen | `agency-ui-pipeline` (Lazyweb → Stitch) + `agency-rich-ui` |
| **React component supply** | **this skill** + 21st MCP |
| Catalog / CLI details | `21st-cli-use` |
| Project-aware build / explore / review | `21st-ui-build` / `21st-ui-explore` / `21st-ui-review` |
| Hosted AI sketch (only if AI enabled) | `21st-ai` |
| Publish / theme sync / video | `21st-registry` / `21st-design-sync` / `21st-video` |

1. Route substantive repo work via `agency-project-gateway`.
2. Product **design** still runs Lazyweb → Stitch first. 21st is the **implement**
   supply layer for React/Tailwind/shadcn (and Expo when asked) — not a Stitch replacement.
3. Prefer the **21st MCP** over inventing components from scratch when a catalog
   match exists.

## MCP (required)

| Agent | Config | Tool names |
|---|---|---|
| Cursor | `~/.cursor/mcp.json` server `21st` | namespace `user-21st` |
| Claude Code | user-scope MCP `21st` | `mcp__21st__*` |

Core tools (authoritative list = server `tools/list`):

- `search` — catalog metadata (free)
- `get_component` — pull code by id (metered)
- `get_inspiration` — search reranked vs project Design Context
- `search_logo` — brand/UI SVG logos (free)
- `generate` / iterate / take — hosted 21st AI (only when `get_usage.aiGenerationEnabled`)
- `get_usage` — quota + AI access

Old Magic MCP names still work and are translated (`21st_magic_component_*` → new tools).

**Auth:** API key `21st_sk_…` from https://21st.dev/mcp as header `x-api-key`
(env `API_KEY_21ST` / `TWENTYFIRST_TOKEN`). Or `21st login` for CLI session.

If MCP is missing / `needsAuth` / errors: fix the global entry, ask user to paste
a key and reload MCPs — do not silently skip 21st on React web implement asks.

## When to use

- Installing or adapting a React + Tailwind / shadcn component from the catalog
- Logo SVG search for product UI
- Exploring alternate React UI directions after Stitch (or when user asks for catalog options)
- Publishing a component/theme (user explicitly asked)

## React Bits fallback (free tier)

When 21st search misses an animated background / creative React component:
use [React Bits](https://reactbits.dev) (install/copy source into the **app**).
License is MIT + Commons Clause — **use in products OK**; do **not** vendor or
resell a React Bits component registry inside the agency kit. Skip React Bits
**Pro** unless the user opts in. See `agency-web-craft`.

## When to skip

- Native Android / iOS / KMP Compose / SwiftUI (use platform engineers + Stitch)
- Backend, infra, non-UI
- Packet already records 21st component ids / install paths for this workstream
- Hosted `generate` when `aiGenerationEnabled` is false — search + `get_component` + local adapt instead

## Procedure

1. Confirm React (or Expo/RN if user asked) web/UI implement path.
2. Ensure design context: `.21st/design.json` / `.21st/DESIGN.md` — if missing and
   useful, `21st init --design-context` (or MCP equivalent).
3. **Search first** (MCP `search` / CLI `21st search`) before hand-writing.
4. Retrieve with `get_component` or install with `21st add <user>/<slug>` when it
   fits; adapt to project tokens/components (follow `21st-ui-build`).
5. Check `get_usage` before any hosted AI generation. Never retry
   `ai_subscription_required` until AI is enabled.
6. Fill packet line:

```markdown
- 21st (React supply): search query + component id(s)/slug(s) + installed paths | n/a
```

7. Run project checks; optional `21st review` for mechanical a11y/token drift.

## Anti-patterns

- Replacing Lazyweb→Stitch with 21st for product screen **design**
- Pasting sketch HTML into a React/tokenized codebase as production
- Calling hosted `generate` without confirming AI access
- Using 21st for native mobile UI
- Inventing “catalog” components when MCP/search failed

## Failure modes

| Failure | Action |
|---|---|
| MCP missing / auth | Point to https://21st.dev/mcp; set `x-api-key`; reload MCPs |
| Free retrieval quota | Surface usage; reuse already-fetched code; do not burn retries |
| `ai_subscription_required` | Stop generate; search → get_component → local adapt |
| No React stack | Skip; implement with platform conventions |
