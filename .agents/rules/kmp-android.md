---
description: KMP / Android / Compose conventions
globs: "**/*.{kt,kts,gradle.kts}"
paths:
  - "**/*.{kt,kts,gradle.kts}"
alwaysApply: false
---

# KMP / Android

- **New apps / bootstrap:** load skill `agency-app-architecture` first (Clean Architecture, MVVM+MVI, KMP cores, `build-logic` convention plugins).
- Follow existing module boundaries and Gradle conventions; prefer `agency-kmp-engineer` / `agency-android-developer` / `agency-build-governance` for larger work.
- Presentation: Intent → ViewModel → UiState / UiEffect; no business logic in Composables; dedicated `*Mapper` types.
- Reuse existing DI, navigation, and design-system patterns.
- UI screens: Lazyweb evidence first when changing product UI.
- **Always** add Compose / CMP motion per `agency-rich-ui` (enter/exit, press, stagger, shared element / content-size). Static layouts are incomplete.
- Keep project design tokens — do not paste portfolio teal/purple onto branded apps.
- Avoid new libraries unless necessary; match versions already in the project. Prefer first-party Compose animation APIs before extra kits.
