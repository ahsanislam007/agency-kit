---
name: agency-app-architecture
description: >
  Canonical multi-module app scaffold: Clean Architecture, SOLID, KMP shared
  cores when mobile, MVVM + unidirectional MVI (Intent/UiState/UiEffect/ViewModel),
  build-logic Gradle convention plugins, dedicated mappers, optional owned analytics
  SDK. Use when creating a new app/repo, bootstrapping Android/KMP modules,
  modularizing, or choosing presentation/Gradle layout. Do NOT use for web-only
  marketing sites, one-file scripts, or home/no-repo chat.
disable-model-invocation: false
---

# Agency app architecture (new apps)

**Default scaffold for every new mobile / KMP app.** Gateway, CTO, build-governance, and KMP/Android engineers load this before inventing module trees.

## Repo gate

Skip for home / empty-window / no git repo / trivial Q&A. For product apps, run after `agency-project-gateway` triage.

## Locked defaults

| Concern | Default |
|---------|---------|
| Layers | Clean Architecture: UI → ViewModel → UseCase → Domain ← Data implements ports |
| Presentation | **MVVM + MVI contracts** — `*Intent`, immutable `*UiState`, one-shot `*UiEffect`, `*ViewModel` |
| Shared logic (mobile) | **KMP** `commonMain` for domain / data / analytics |
| Ship UI (until iOS funded) | Jetpack Compose in `:androidApp` (CMP shared UI deferred) |
| Build | **`build-logic` convention plugins** + `gradle/libs.versions.toml` |
| Mappers | Dedicated `*Mapper` objects — never inside enums / ViewModels / UI |
| Analytics | Prefer owned `:core:analytics` with **NoOp** default; no paid vendor until ADR |
| Ponytail | No speculative `:feature:*` Gradle modules, `:backend`, or Maps SDK without a real consumer |

Reference pattern: a prior KMP app using the same module tree and convention plugins (discover per repo; do not hardcode another product’s package ids).

## Canonical module tree

```text
{app}/
  build-logic/convention/     # included build — convention plugins only
  gradle/libs.versions.toml
  :androidApp                 # Application, Hilt, Compose, platform adapters, feature VMs
  :core:domain                # pure Kotlin/KMP — models, use cases, repository ports
  :core:data                  # repository impls, local DB/prefs, parsers
  :core:analytics             # owned SDK (optional but preferred)
  :core:testing               # fakes / fixtures
  # add :core:regionpacks | :core:network | :feature:* only with an active boundary
```

**Phase-0 / MVP rule:** keep feature ViewModels as packages under `:androidApp` (`feature/{name}/`). Promote to `:feature:{name}` Gradle modules only when a second platform or app module needs the same feature.

## MVI contract (required per screen)

```text
UI --Intent--> ViewModel --UiState--> UI
                 |
                 +--UiEffect--> one-shot (nav, TTS, snackbar, share)
ViewModel --> UseCase --> ports (repos / TTS / analytics)
```

Rules:

1. Composables emit Intents and render State — **no business logic**.
2. ViewModels are deterministic reducers + use-case callers — **no Android framework** types in KMP ViewModels; Android ViewModels may wrap platform adapters at the edge.
3. Effects are consumed once (Channel / SharedFlow).
4. Mapping UI ↔ domain goes through dedicated mappers.

See [reference.md](reference.md) for Intent/State/Effect/ViewModel skeletons and Gradle plugin ids.

## Convention plugins (required)

Place under `build-logic/convention`. Modules **apply plugins**; they do not hardcode AGP/Kotlin/Compose versions.

| Plugin id | Use on |
|-----------|--------|
| `com.example.agency.kmp.library` | KMP library modules (`:core:*`) |
| `com.example.agency.android.application` | `:androidApp` |
| `com.example.agency.android.library` | Android-only libraries |
| `com.example.agency.compose` | Any module with Compose |
| `com.example.agency.testing` | Test conventions |

Namespace prefix may become `com.{brand}.*` for the product — keep the **same plugin roles**.

## Procedure (new app)

1. Confirm package id, ship targets (Android-only vs iOS), and offline/$0 constraints.
2. Create module tree above — do not add unused modules.
3. Scaffold `build-logic` + version catalog first (`agency-build-governance`).
4. Implement `:core:domain` + one pure unit test before UI.
5. Wire `:core:data` + `:core:analytics` (NoOp sink).
6. Build `:androidApp` shell: theme, nav, Hilt, one feature with full MVI loop.
7. Product UI screens → `agency-ui-pipeline` + `agency-rich-ui` (motion required).
8. Packet must list: module tree, plugin ids, first feature MVI types, analytics default sink.

## Gateway / specialist wiring

- **Gateway:** on “new app”, “bootstrap”, “scaffold”, “multi-module”, “MVVM/MVI”, “convention plugins” → load this skill before CTO / build-governance / kmp / android agents.
- **CTO:** architecture ADR must cite this skill’s module + MVI defaults or document an explicit override.
- **Build-governance:** owns `build-logic` plugin implementations matching the table.
- **KMP / Android engineers:** implement against the tree; refuse God modules and logic-in-Composable.

## Anti-patterns

- Single-module “everything in `:app`” for a product that will grow
- Copy-pasting dependency versions into every `build.gradle.kts`
- MVI in name only (mutable public state, business logic in Compose)
- Mapping tables inside enums or ViewModels
- Adding `:feature:*` / `:core:network` / Firebase “for later”
- Paid analytics or remote sinks without privacy + budget ADR

## Verification

- [ ] `build-logic` exists; app modules apply convention plugins only
- [ ] Domain has zero Android/Compose deps
- [ ] At least one feature has Intent / UiState / UiEffect / ViewModel
- [ ] Mappers are separate types
- [ ] Analytics default is NoOp (if module present)
- [ ] No speculative empty modules
