# Approved motion kits

Use the **first** option that matches the stack. Do not invent a new animation framework.

## Web kit order

1. **Project already has a motion lib** → use it (Motion, GSAP, anime.js, etc.). Load matching agent skills (`gsap-*` when the project is on GSAP).
2. **Vanilla HTML/CSS** (marketing / greenfield sites) → implement these primitives in the project (do not depend on a personal local clone):
   - CSS: grain overlay, scroll-progress bar, glass sticky nav, marquee, gradient accents, `prefers-reduced-motion`
   - JS: IntersectionObserver `.reveal` stagger, count-up stats, cursor glow, constellation canvas (pause off-screen), card tilt (`data-tilt`), magnetic primary CTA
   - Always gate continuous FX behind `prefers-reduced-motion` and fine pointer / non-mobile.
   - Optional live demo of the motion language: https://ahsanislam.com (motion patterns only — do not copy its brand palette onto client apps).
3. **React / Next greenfield** → [Motion](https://motion.dev) (`motion` / Framer Motion) + [Magic UI](https://github.com/magicuidesign/magicui) / shadcn animated bits via `agency-21st`. Optional Lenis only for long editorial pages.
4. **Scroll / timeline-heavy** (pinning, scrub, complex sequences) and no Motion yet → [GSAP](https://gsap.com) (100% free incl. plugins) + official skills `gsap-core` / `gsap-timeline` / `gsap-scrolltrigger` / `gsap-react`. Do **not** add GSAP beside an existing Motion stack.
5. **Micro UI transitions** (modal, toast, tabs, badge, skeleton) → free [transitions.dev](https://transitions.dev) recipes via skill `transitions-dev` (CSS; `prefers-reduced-motion` included). Polish tokens with `transitions-polish`. Audit: `npx transitions-agent`. Skip Pro skill/library unless the user pays.
6. **Animated React backgrounds / creative bits** missing from 21st → [React Bits](https://reactbits.dev) CLI/copy into the app only (MIT + Commons Clause — do not redistribute a component pack inside the agency kit).
7. Never add a second competing animation stack.

Router overview: `agency-web-craft`. Token extract from a live URL: `agency-designlang`.

### Agency web motion language (gold standard)

Optional live demo: https://ahsanislam.com (public reference for grain/reveal/progress/glass-nav/tilt — not a required brand).  
Implement primitives in-repo; do not require a personal source tree.

| Primitive | Role |
|---|---|
| Grain + constellation canvas | Ambient depth (pause when hero off-screen / tab hidden) |
| Cursor glow | Pointer-fine only |
| Scroll progress | Top 2px gradient bar |
| Glass sticky nav | Blur + stuck border on scroll |
| `.reveal` stagger | IO threshold ~0.15, delay by sibling index |
| Count-up `[data-count]` | Ease-out cubic ~1100ms |
| Card tilt | perspective 900px, ±4° |
| Magnetic primary CTA | translate toward pointer ×0.18 / 0.3 |
| Infinite marquee | CSS keyframes |
| Theme toggle | Instant swap + stored preference |

**Do not** paste a demo portfolio palette onto branded product apps — motion primitives only unless the packet locks that brand.

## Mobile kit order (Android / KMP / iOS)

1. **First-party (preferred):**
   - Compose / CMP: `AnimatedVisibility`, `AnimatedContent`, `animate*AsState` springs, `animateContentSize`, `SharedTransitionLayout`, list item stagger, sheet/scrim fade
   - iOS SwiftUI: `withAnimation`, `matchedGeometryEffect`, `PhaseAnimator`, spring press, list stagger
2. **Material 3 motion / Expressive** if the project is already M3.
3. **Lottie** only if already a dependency or illustration-heavy motion.
4. Do **not** add random GitHub UI kits that fight the existing design system.

### Mobile minimum per screen

- Enter/exit for the root content or primary panel
- Press scale / ripple on primary actions
- List or card stagger when showing collections
- Sheet / dialog: scrim fade + content slide or scale
- Shared-element or `animateContentSize` when navigating related content

## When adding a dependency is OK

- Greenfield React and no motion lib yet → add `motion` once (or GSAP once if scroll/timeline-heavy — pick one).
- Greenfield Compose with no shared transitions yet → use androidx Compose animation APIs already on the classpath; avoid extra kits.
- Product app with existing Lottie → reuse; do not add a second vector-animation stack.
- transitions.dev free CSS snippets → no npm dependency required; Pro recipes need a paid plan (opt-in only).

## Greenfield art direction (optional)

- **Locked brand / client packet** → Lazyweb → Stitch; do **not** run taste-skill as the design source of truth.
- **No brand lock**, user wants a designed marketing page → optional skill `design-taste-frontend` (`taste-skill`). Needs Node 22+ and Chromium; ~30–45 min / high tokens. Real CC-licensed photos via its scripts.
