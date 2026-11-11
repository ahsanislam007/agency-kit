---
description: Use agency-reverse-engineer-anything (REA) for authorized shipped-artifact reverse engineering
alwaysApply: true
---

# Agency reverse engineer anything — REA (all projects)

When the user asks to **reverse engineer**, **decompile**, or **analyze a shipped artifact** (native binary, APK/IPA, Electron/JS package, .NET, firmware, browser capture, AgentEnv reconstruction) with evidence from tools rather than source:

1. Route via `agency-project-gateway` first when the ask is substantive agency/repo work.
2. Load skill **`agency-reverse-engineer-anything`** (`~/.agents/skills/agency-reverse-engineer-anything/SKILL.md`).
3. Prefer REA MCP (`rea`) when available; else CLI `npx -y rea-agents@latest` / installed `rea`. Connection repair: skill `references/connection-and-recovery.md`.
4. **Authorized targets only** — refuse DRM cracks, credential theft, malware packaging, unauthorized access, and exploit PoCs.
5. Android **static jadx / Retrofit API extraction / fingerprint scripts** → also load `agency-android-reverse-engineering`. Pair findings with `agency-qa-security`.

Skip when full source is already in the workspace (read the repo instead). Skip pure Maestro/E2E (use `agency-maestro-testing`).
