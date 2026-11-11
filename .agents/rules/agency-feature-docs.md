---
description: After any user-facing feature is added/changed, run agency-feature-docs side skill (README + user guide + screenshots)
alwaysApply: true
---

# Agency feature docs (side skill)

When a **user-facing feature** is added or meaningfully changed in a **git** repo (product UI, Admin/CMS, storefront/app flow, operator-facing capability):

1. Route via `agency-project-gateway` first (same as other agency work).
2. After implementation (same turn / same scope), load and follow skill **`agency-feature-docs`** (`~/.agents/skills/agency-feature-docs/SKILL.md` + `reference.md`).
3. **Required outputs:** update root **README** (short pointer) + project **user guide** (how-to steps) + **screenshots** under `docs/assets/<feature-slug>/` when UI is capturable.
4. Prefer real browser/app screenshots; never fake screenshots with image generators. If the app is not runnable, write accurate steps + `TODO(screenshot)` markers and say so.
5. Prefer inline docs edit; spawn `agency-docs-writer` only for large multi-doc rewrites.
6. Packet must include a `FeatureDocs:` line before calling the work done.

**Skip** for pure refactors, infra/CI-only, secret/env-only, or when the user says “code only” / “skip docs”.
