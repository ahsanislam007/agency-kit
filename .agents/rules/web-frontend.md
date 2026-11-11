---
description: Web frontend conventions
globs: "**/*.{ts,tsx,js,jsx,css,scss,vue,svelte}"
paths:
  - "**/*.{ts,tsx,js,jsx,css,scss,vue,svelte}"
alwaysApply: false
---

# Web frontend

- Match existing component patterns, styling system, and router.
- Product UI changes: Lazyweb → Stitch first; implement via `agency-frontend-web-engineer` when multi-step.
- React/Tailwind/shadcn: load `agency-21st` and prefer the 21st MCP catalog (`search` / `get_component` / `21st add`) before hand-rolling lookalikes.
- Prefer accessible diffs; no generic purple/AI aesthetic unless brand requires it.
- Match brand tokens; **always** add platform motion per `agency-rich-ui`.
- Marketing / greenfield sites: agency web motion language (optional demo: ahsanislam.com) (grain, reveal, scroll progress, glass nav, tilt/magnetic CTAs) or Motion + Magic UI on React.
- Avoid adding a second UI/motion kit when one already exists; prefer approved kits in `agency-rich-ui` / `kits.md`.
