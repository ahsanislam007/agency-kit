---
description: Use agency-maestro-testing for native Maestro YAML/flow authoring on every mobile project
alwaysApply: true
---

# Agency Maestro testing (all projects)

When writing, reviewing, or debugging **Maestro** flows for native Android/iOS (Compose, Views, SwiftUI, UIKit):

1. Load skill **`agency-maestro-testing`** (`~/.agents/skills/agency-maestro-testing/SKILL.md`).
2. Run via the global Maestro MCP (`user-maestro` in Cursor, `mcp__maestro__*` in Claude Code).
3. Scaffolding / CI / agent-device still uses **`agency-mobile-test-setup`**.

Skip for React Native/Expo unless the user says so; skip unit-test-only and non-mobile work.
