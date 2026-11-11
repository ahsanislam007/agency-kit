---
name: agency-designlang
description: >
  Extract and verify live-site design systems with the free designlang CLI/MCP
  (tokens, motion, brand drift). Use when cloning a reference URL’s colours/
  type/spacing into Tailwind/shadcn/DTCG, checking brand drift in CI, capturing
  CSS interactions/motion tokens, or wiring designlang MCP. Skip when the
  project already has a locked brand packet (use packet tokens), for native
  mobile-only work with no web reference, or when Lazyweb→Stitch already filled
  the design without a live URL to extract.
disable-model-invocation: false
---

# Agency designlang (token extract + verify)

**Free / MIT** CLI + stdio MCP. Hosted “reads” on designlang.app may be freemium;
agency default = **local CLI only** (no account).

Docs: https://designlang.app · npm `designlang` · source github.com/Manavarya09/design-extract

## When to use

- User pasted a **reference URL** and wants tokens / Tailwind / shadcn theme
- Verify implement against extracted brand (`designlang check`)
- Capture hover/focus/transitions (`--interactions`) or runtime motion (`--motion-runtime`)
- CI drift gate (`designlang ci`) against a known extraction

## When to skip

- Locked client brand already in `.agency/context-packet` / design tokens — **do not override**
- No live URL; design is Stitch/Lazyweb-only
- Native Android/iOS/KMP with no web reference to extract

## Procedure

1. Extract (project root):

```bash
npx designlang <url> -o ./design-extract-output --framework shadcn --interactions
# optional: --motion-runtime --responsive --emit-agent-rules
```

2. Prefer outputs: DTCG JSON, CSS variables, Tailwind/shadcn theme, motion tokens.
3. MCP (global Cursor server `designlang`): exposes the **latest** extraction under
   `--output-dir` (default `./design-extract-output`). Run extract first, then use MCP tools.
4. Brand lock: merge extracted tokens into the project **only** when the user asked
   to match that URL, or when bootstrapping a greenfield without a locked packet.
5. Packet line:

```markdown
- Designlang: url + out dir + formats used | n/a
```

## Anti-patterns

- Overwriting locked-brand packet tokens from a random competitor URL
- Treating hosted designlang.app credits as required (CLI is enough)
- Shipping extracted fonts/assets without checking license
