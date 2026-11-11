---
description: Use agency-android-reverse-engineering for authorized Android APK/XAPK decompile and API extraction
alwaysApply: true
---

# Agency Android reverse engineering (all projects)

When the user asks to **decompile**, **reverse engineer**, **fingerprint**, or **extract APIs** from an Android **APK / XAPK / JAR / AAR** (jadx, Fernflower, call-flow, Retrofit endpoints):

1. Route via `agency-project-gateway` first when the ask is substantive agency/repo work.
2. Load skill **`agency-android-reverse-engineering`** (`~/.agents/skills/agency-android-reverse-engineering/SKILL.md`).
3. **Authorized targets only** — refuse DRM cracks, credential theft, malware packaging, unauthorized access, and exploit PoCs.
4. Prefer the skill’s `scripts/` (fingerprint → check-deps → decompile → find-api-calls). Pair findings with `agency-qa-security`.

Skip when full source is already in the workspace (read the repo instead). Skip pure Maestro/E2E (use `agency-maestro-testing`). For broader REA (native/Electron/firmware/AgentEnv) use `agency-reverse-engineer-anything`.
