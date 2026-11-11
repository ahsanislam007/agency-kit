---
name: stitch-design
description: >
  Use Google Stitch MCP to generate and iterate mobile/web UI screens for
  product design work. For agency UI work, run after Lazyweb via
  agency-ui-pipeline. Use when designing, redesigning, creating screens, or
  when agency-* agents need design references from Stitch.
  Do NOT use before Lazyweb on agency design requests, for backend/CLI/infra,
  prose-only edits, non-product visuals, or home/no-repo workspaces.
disable-model-invocation: false
---

# Stitch design

Google Stitch generates product UI screens. For agency work, run **after** Lazyweb
research via `agency-ui-pipeline` — embed Lazyweb patterns in Stitch prompts.

## Repo gate

**Skip / no-op** when there is no git repository or the workspace is home / empty-window only.

## Prerequisites

- Stitch MCP server must be connected (Cursor: `~/.cursor/mcp.json`; Claude Code: `claude mcp list`).
- If tools are missing or auth fails, tell the user to run:
  `npx @_davideast/stitch-mcp init -y --defaults -c <client>` (`cursor`; see `--help` for others)
  or set API key from [stitch.withgoogle.com](https://stitch.withgoogle.com/) settings.

## When to use

- Step 2 of `agency-ui-pipeline` (after Lazyweb search/report)
- Standalone Stitch iteration when packet already has Lazyweb fields
- User asks for Stitch, mockups, or "generate this screen"

## When to skip

- No git repo / home-only
- Backend/CLI/infra, prose-only, non-product visuals
- Agency design request with empty Lazyweb fields (run pipeline Step 1 first)

## Workflow (mobile-first)

1. **Project** — `list_projects` or `create_project` for this feature.
2. **Generate** — `generate_screen_from_text` with platform, screen type, hierarchy, CTA, constraints, Lazyweb patterns, **and motion** (per `agency-rich-ui`): enter/exit, list/card stagger, press/hover, shared-element or sheet-scrim — never a static flat frame.
3. **Preview** — `get_screen`, then `download_file` with its `screenshot.name`; show the user the screen.
4. **Code** — `download_file` with `html_code.name` (or `download_assets` for the whole project) when implementing.
5. **Iterate** — `edit_screens` / `generate_variants`; keep one project per feature. Generation takes
   minutes: do not retry on timeout; check `get_screen` / `list_screens` instead.
6. **Consistent style** — one design system per project: `create_design_system` (or `upload_design_md` →
   `create_design_system_from_design_md`), then `apply_design_system` to sibling screens.

## Agency routing

Routers (`agency-project-gateway`, `agency-chief-of-staff`) run the full
`agency-ui-pipeline` before launching design/frontend specialists.

Specialists consume Stitch fields from the context packet; run Stitch steps
only if packet Stitch fields are empty.

## Anti-patterns

- Generating without Lazyweb patterns on agency UI work
- Generating static frames with no motion language in the prompt
- New Stitch project per trivial iteration of the same screen
- Skipping image preview before implementation handoff

## Verification checklist

- [ ] Repo gate passed
- [ ] Lazyweb patterns included (or packet already had them)
- [ ] Motion constraints in generate prompt (`agency-rich-ui`)
- [ ] Project id + screen id(s) recorded
- [ ] Image fetched for user preview when generating new screens

## Failure modes

| Failure | Action |
|---|---|
| Auth / missing MCP | Init command + stitch.withgoogle.com; stop |
| Empty generation | Tighten prompt (platform, hierarchy, CTA, patterns); retry once |
