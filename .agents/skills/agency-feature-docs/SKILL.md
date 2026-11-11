---
name: agency-feature-docs
description: >
  Side skill that runs after a user-facing feature is added or changed: update
  README and the project user guide with how-to steps plus screenshots. Use when
  shipping a feature, finishing product UI, adding Admin/CMS/storefront flows,
  or when Done-when includes docs. Also use when the user says update docs /
  README / user guide / admin guide after a feature. Do NOT use for pure
  refactors, infra-only, or secret-bearing changes with no user-visible surface.
disable-model-invocation: false
---

# Agency feature docs (side skill)

**Companion to feature work** — not a replacement for build. After a user-facing
feature lands, docs must land in the **same turn / same PR scope** unless the
user explicitly says “code only” / “skip docs”.

## Repo gate

**Activate** only inside a **git** project.  
**Skip** home / empty-window / no user-visible surface.

## When to run (auto)

Run this skill whenever **any** of these is true:

1. A new product feature, screen, Admin/CMS flow, or storefront capability was implemented
2. An existing user-facing flow changed enough that old steps/screenshots are wrong
3. Packet `Done when` / user ask includes docs, README, user guide, or screenshots
4. Gateway tagged the workstream as feature impl and build just finished

**Skip** for: pure refactors, dependency bumps, CI/infra with no UX, typo fixes, secret/env-only edits, or when the user said skip docs.

## Discover (per repo)

| Need | How |
|------|-----|
| README | Root `README.md` (create a short Docs / Features row if missing) |
| User guide | Prefer existing: `docs/admin-guide.md`, `docs/USER_GUIDE.md`, `docs/user-guide.md`, `docs/guides/*.md`. Else create `docs/user-guide.md` |
| Screenshot dir | `docs/assets/<feature-slug>/` (create if missing) |
| Audience | Client/operator vs developer — match the guide that already exists |
| URLs | Prod + local from README / ops / admin-guide; never invent domains |

Typical default: README Docs table + `docs/admin-guide.md` (or `docs/user-guide.md`) + `docs/assets/<slug>/`.

## Procedure (after feature code works)

1. Confirm git repo + root (`move_agent_to_root` if needed).
2. Orient with graphify if present: `graphify query "readme user guide admin-guide docs"`.
3. Fill packet line: `FeatureDocs: yes | guide=<path> | screenshots=docs/assets/<slug>/`.
4. Write/update **user guide** section first (how to use), then **README** pointer.
5. Capture **screenshots** of the real UI (see below); embed relative Markdown images.
6. Prefer **inline** docs edit. Spawn `agency-docs-writer` only if multi-lane or large rewrite.
7. Keep diffs minimal — ponytail. Do not invent redesigns or unsolicited extra markdown books.
8. Do not commit unless asked. After code/docs edits: `graphify update .` if graphify-out exists.

## README update (short)

- Add or refresh **one** Docs-table row / Features bullet pointing at the guide section.
- One sentence on what the feature is for operators/devs — no essay.
- Link to the exact guide heading when possible: `docs/admin-guide.md#slug`.

## User guide update (required)

For each feature, add a numbered how-to section using the template in
[reference.md](reference.md):

- Title + one-line purpose
- Prerequisites (roles, URLs, env)
- Step-by-step (click paths, not internals)
- Screenshots under key steps
- Short troubleshooting (1–3 bullets) only if failure modes are real

## Screenshots (required for UI surfaces)

Capture real pixels of the shipped UI — do not paste Stitch mockups as “how to use”.

| Surface | Capture with |
|---------|----------------|
| Web / Admin / CMS | Cursor: `cursor-ide-browser` → navigate → `browser_take_screenshot` (or CDP capture). Elsewhere: Playwright / Chrome DevTools MCP screenshot |
| Desktop app UI | Cursor: `cursor-computer-use` screenshot. Elsewhere: OS tool (`screencapture` on macOS) |
| Mobile | `adb exec-out screencap -p > shot.png` (Android) · `xcrun simctl io booted screenshot shot.png` (iOS sim) · Maestro `takeScreenshot` · `agent-device screenshot` |

Rules:

1. Save PNG/JPEG under `docs/assets/<feature-slug>/01-login.png`, `02-create.png`, …
2. Filename = step order + short kebab action
3. Crop to the relevant panel when possible; avoid huge full-desktop noise
4. Redact secrets, emails of real people, tokens, and PII before committing paths
5. Embed as `![Alt text](assets/<feature-slug>/01-login.png)` from the guide file
6. If the app is not runnable this turn: write steps + `<!-- TODO(screenshot): <url or route> -->` and tell the user what’s missing — do **not** fake screenshots with GenerateImage

## Done when

- [ ] User guide has a how-to section for the feature
- [ ] README points at that guide (table row or bullet)
- [ ] Screenshots exist for UI steps **or** explicit TODO markers + reason
- [ ] No secrets in docs/images
- [ ] Packet `FeatureDocs` filled

## Anti-patterns

- Shipping a user-facing feature with no guide update
- Developer-only API dumps in the client admin guide
- Fake AI-generated “screenshots”
- Duplicating the same essay in README and the guide
- Rewriting unrelated docs chapters
- Committing `.env` or credential screenshots
