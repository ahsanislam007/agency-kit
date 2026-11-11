---
name: agency-web-craft
description: >
  Agency router for free web-craft skills: GSAP official skills, transitions.dev
  free recipes + motion agent, React Bits install pointers, taste-skill
  (design-taste-frontend) for greenfield art direction, and designlang token
  extract. Use when choosing motion/component supply for website builds beyond
  Lazyweb→Stitch→21st. Skip for native mobile-only, backend/CLI, or when
  agency-rich-ui kits.md already decides the stack.
disable-model-invocation: false
---

# Agency web craft (free supply ladder)

Complements `agency-ui-pipeline` + `agency-rich-ui` + `agency-21st`. **Does not**
replace Lazyweb→Stitch for locked-brand product screens.

## Free stack (installed)

| Tool | Skill / command | Role |
|------|-----------------|------|
| **GSAP** | `gsap-core`, `gsap-timeline`, `gsap-scrolltrigger`, `gsap-react`, … | Timelines, ScrollTrigger, `useGSAP` — all plugins free |
| **transitions.dev** | `transitions-dev`, `transitions-polish`, `transitions-ui-generation` | CSS transition recipes + token polish. Audit: `npx transitions-agent` |
| **designlang** | `agency-designlang` + MCP `designlang` | URL → tokens / motion extract / brand check |
| **taste-skill** | `design-taste-frontend` / `taste-skill` | Greenfield art direction + browser slop gate (opt-in; ~30–45m) |
| **React Bits** | CLI/docs only — https://reactbits.dev | Animated React components as **source you own**; MIT + Commons Clause |

## Paid — do **not** install by default

- transitions.dev **Pro** library / Pro skill (`npx transitions-dev skill`)
- React Bits **Pro** Agent Kit

## Routing (pick one primary)

1. **Locked brand product UI** → Lazyweb → Stitch → `agency-rich-ui` → `agency-21st` (React).
2. **Reference URL tokens** → `agency-designlang` (then implement; still Stitch if screens needed).
3. **Scroll/timeline-heavy web** → keep one lib: existing project lib, else GSAP (`gsap-*` skills) **or** Motion — never both.
4. **Micro UI transitions (modal/toast/tabs)** → `transitions-dev` CSS recipes; audit with `npx transitions-agent`.
5. **Animated React bit missing from 21st** → React Bits CLI/copy into the app (do **not** vendor a component registry in the agency kit).
6. **Greenfield marketing with no brand lock** → optional `design-taste-frontend` (user opt-in; high token cost).

Details and kit order: `agency-rich-ui` → [kits.md](../agency-rich-ui/kits.md).

## Update upstream skills

```bash
# re-clone into durable vendor + relink (or: npx skills add … -g -y)
VENDOR="$HOME/.agents/vendor"
git -C "$VENDOR/gsap-skills" pull --ff-only
git -C "$VENDOR/transitions.dev" pull --ff-only
git -C "$VENDOR/taste-skill" pull --ff-only
```
