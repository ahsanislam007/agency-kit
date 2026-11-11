---
name: agency-rich-ui
description: >
  Mandatory premium motion for every product UI screen. Use when designing,
  redesigning, implementing, or polishing screens on web (React/Next/HTML),
  Android Compose, KMP/CMP, SwiftUI, landings, dashboards, paywalls, onboarding,
  checkout, or settings — or when the user mentions animation, motion, rich UI,
  or premium polish. Do NOT skip for "smallest change" on visual work; skip only
  when the user said no animation, reduced-motion-only, or the task is
  backend/CLI/infra with no UI.
disable-model-invocation: false
---

# Agency rich UI (motion mandatory)

**Static screens are a failed handoff.** Every new or changed user-facing screen
must ship enter/exit, press/hover, and scroll-aware motion unless the user
explicitly waived animation.

Read [kits.md](kits.md) for approved libraries and copy-paste catalogs.

## Two bars (not one look)

| Surface | Motion bar | Visual tokens |
|---|---|---|
| **Web** marketing / greenfield | agency web motion language ([optional demo](https://ahsanislam.com)) — see kits.md | May match the optional demo site |
| **Android / KMP / iOS product apps** | First-party Compose / SwiftUI springs + shared element | **Keep project design tokens** — do not paste teal/purple portfolio palette |

## Hard fail

Ship incomplete if a new/changed screen has **none** of:

- Enter / exit (or content swap)
- Press / hover feedback
- Scroll-aware motion (reveal, parallax, progress, list stagger)

**Waive only when:** user said “no animation”, reduced-motion-only deliverable, or non-UI task.

## Always

1. Honor `prefers-reduced-motion` / OS reduce-motion (instant or opacity-only fallbacks).
2. Pause canvas / continuous FX when off-screen or tab hidden.
3. Prefer project motion deps → first-party platform APIs → approved kits in [kits.md](kits.md).
4. Never invent a new animation framework when an approved kit covers it.
5. Ponytail stays for architecture/logic; **product UI motion is not YAGNI**.

## Screen checklist (copy into Done-when)

```
- [ ] Enter / exit or AnimatedContent / matched geometry
- [ ] Press / hover (scale, magnetic CTA, or ripple)
- [ ] Scroll reveal / list stagger / sheet-scrim
- [ ] Reduced-motion path verified
- [ ] Web marketing: agency motion primitives (grain/nav/reveal/progress) OR Motion + Magic UI
- [ ] Mobile: Compose/SwiftUI first-party APIs (not static layouts)
```

## Router duty

`agency-project-gateway` / `agency-chief-of-staff` / `agency-ui-pipeline`:

1. Read this skill after Lazyweb.
2. Put motion constraints in the context packet (`Motion:` line).
3. Embed motion in Stitch prompts (stagger, shared element, hover/press).
4. Specialists fail the handoff if UI ships static.

## Anti-patterns

- Flat Compose / SwiftUI with no `animate*` / `AnimatedVisibility` / `withAnimation`
- Landing pages without reveal, sticky glass nav, or scroll progress
- Adding random GitHub UI kits that fight the existing design system
- Copying a demo portfolio palette onto branded product apps
- Skipping motion because ponytail said “smallest change”
