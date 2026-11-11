---
name: agency-ui-pipeline
description: >
  Canonical agency UI workflow: Lazyweb for research/evidence, then Stitch for
  screen generation, then agency-21st for React catalog supply on implement.
  Use when routing product UI/design work through gateway or chief-of-staff,
  when packet Lazyweb/Stitch fields are missing, or when the user asks to
  design/redesign/optimize/improve a screen, paywall, pricing, onboarding,
  landing, checkout, dashboard, or settings UI.
  Do NOT use for backend/CLI/infra, prose-only edits, non-product visuals,
  home/no-repo workspaces, or when both packet fields are already populated.
disable-model-invocation: false
---

# Agency UI pipeline: Lazyweb refs → Stitch design → 21st supply (React)

Run **once** per UI workstream at the router (gateway / chief-of-staff).
Specialists consume the packet — do not re-run unless Lazyweb/Stitch fields are empty.
React implement agents also load `agency-21st` when installing catalog components.

## Repo gate

**Skip / no-op** when there is no git repository or the workspace is home / empty-window only. UI pipeline is project-scoped.

## When to use

- Product UI: design, redesign, critique, optimize, improve, create screen
- High-stakes surfaces: paywall, pricing, onboarding, landing, checkout
- Packet missing Lazyweb and/or Stitch fields before design/frontend agents

## When to skip

- No git repo / home-only
- Backend, CLI, infra, prose-only, non-product visuals
- Packet already has both Lazyweb + Stitch fields filled
- Non-UI agency work

## Procedure

### Step 1 — Lazyweb (research)

If the Lazyweb server only exposes `lazyweb_discover_tools` / `lazyweb_execute` (code mode),
call the tools below as `await tools.<name>(args)` inside `lazyweb_execute`.

1. **`lazyweb_search`** — concrete 2–6 word UI pattern + platform (`mobile` or `desktop`).
   Include `skill: "agency-ui-pipeline"` on every `lazyweb_*` call. Results are
   deterministic: never repeat an identical query; page with `offset`.
2. **Report (existing screen only)** — also run `lazyweb_generate_report` when redesigning /
   optimizing / improving a screen that exists, especially the high-stakes screens above:
   - Upload screenshot via `lazyweb_request_image_upload` → PUT raw bytes → `lazyweb_resolve_image_upload` → pass `image_url`
   - Async (~3–4 min): poll `lazyweb_get_report` every ~10s until `done`, then share `result.url`
   - Greenfield (no screen yet): skip the report — `objective: "create"` only returns a redirect.
     Use `lazyweb_search_screens` / `lazyweb_search_flows` for references instead.
3. **Monetization (optional)** — `lazyweb_search_ab_tests` before report on paywall/pricing/lifecycle screens.
4. **Errors** — relay `MCP_PRO_REQUIRED`, `FREE_REPORT_DAILY_LIMIT`; do not invent references.
5. Extract **2–3 key patterns** for the Stitch prompt (+ report URL if any).

### Step 1b — Rich UI (motion bar)

Read `agency-rich-ui` (and its `kits.md` if needed). Static frames are incomplete:

- Web marketing / greenfield → agency web motion language (optional demo: ahsanislam.com) (or Motion + Magic UI on React).
- Mobile → Compose / SwiftUI first-party springs, shared element, stagger, press.
- Embed motion in every Stitch prompt (stagger, shared element, hover/press).
- Extra free supply (GSAP skills, transitions.dev, React Bits pointer, taste-skill): `agency-web-craft`.

### Step 1c — Optional branches (not a Stitch replacement)

| Case | Action |
|------|--------|
| **Locked brand** in packet / client draft | Stay on Lazyweb → Stitch; ignore taste-skill art direction |
| **Reference URL** for tokens/motion | `agency-designlang` (`npx designlang <url> …`) — extract/verify only; still Stitch for new screens |
| **Greenfield marketing, no brand lock**, user opts in | `design-taste-frontend` (taste-skill) for art direction + browser gate |
| **Motion audit** on an existing web codebase | `npx transitions-agent` (+ skill `transitions-dev` / `transitions-polish`) |

### Step 2 — Stitch (design)

Follow `stitch-design`, embedding Lazyweb patterns **and motion** in `generate_screen_from_text`:

1. `list_projects` or `create_project` for this feature.
2. `generate_screen_from_text` — platform, screen type, hierarchy, CTA, Lazyweb patterns, **motion** (enter/exit, stagger, press/hover).
   Takes minutes: do not retry on timeout; check `get_screen` / `list_screens` instead.
3. `get_screen` → `download_file` with its `screenshot.name` — preview for user.
4. `download_file` with `html_code.name` (or `download_assets` for the whole project) — when implementing.
5. Sibling screens share one design system: `create_design_system` (or `upload_design_md` →
   `create_design_system_from_design_md`), then `apply_design_system`; iterate with `edit_screens` / `generate_variants`.

**Stitch auth errors** — set `STITCH_API_KEY` from [stitch.withgoogle.com](https://stitch.withgoogle.com/)
settings in that agent's MCP config, or run `npx @_davideast/stitch-mcp init -y --defaults -c <client>`
(`cursor`; see `--help` for other clients).

### Step 2b — 21st (React implement supply)

After design, when the stack is React/Tailwind/shadcn (or Expo when asked), load
`agency-21st` and prefer the 21st MCP (`user-21st` / `mcp__21st__*`) to search/install
catalog components instead of hand-rolling lookalikes. If 21st has no match for a
creative/animated bit, fall back to [React Bits](https://reactbits.dev) CLI/copy
(pointer only — Commons Clause). Do **not** replace Lazyweb or Stitch with 21st
for design. Skip on native Android/iOS/KMP. Check `get_usage` before hosted AI
generate. Details: https://21st.dev/mcp

### Step 3 — Packet

Fill before specialists:

```markdown
- Lazyweb (UI only): search query + platform + report URL(s) + 2-3 key patterns
- Stitch (UI only): project id + screen id(s) + image/code paths
- Motion: web=agency motion language (optional demo ahsanislam.com) | mobile=compose/swift springs
- 21st (React supply): search query + component id(s)/slug(s) + installed paths | n/a
```

Use `n/a` for Motion only on non-UI work — never omit the line on UI workstreams.
Use `n/a` for 21st on non-React / native mobile workstreams.

## Anti-patterns

- Stitch before Lazyweb on a design request
- Hand-writing a “report” from search piles instead of `lazyweb_generate_report`
- Inline huge `image_base64` for full-res screenshots (prefer upload flow)
- Re-running the pipeline in every specialist
- Inventing competitor UI “references” when MCP errors
- Stitch / handoff without motion constraints (static UI)

## Verification checklist

- [ ] Git repo present (else skipped)
- [ ] Lazyweb search done with platform + skill tag
- [ ] Report/upload used when redesign/optimize/create or high-stakes
- [ ] 2–3 patterns extracted for Stitch
- [ ] `agency-rich-ui` applied; Motion line in packet
- [ ] Stitch prompts include motion (not static frames)
- [ ] Stitch project + screen ids recorded in packet
- [ ] React implement: `agency-21st` considered; 21st packet line set (or n/a)
- [ ] Specialists receive packet; pipeline not duplicated

## Failure modes

| Failure | Action |
|---|---|
| Lazyweb plan/limit error | Surface exact error; continue with search-only patterns if allowed, else stop |
| Stitch MCP missing/auth | Give init/API-key instructions; do not fake screens |
| 21st MCP missing/auth | Point to https://21st.dev/mcp for `x-api-key`; reload MCPs; do not invent catalog hits |
| No screenshot for report | Capture/upload first; do not pass truncated base64 |
