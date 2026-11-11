# Templates (substitute per project)

Placeholders:

- `{{APP_ID}}` — e.g. `com.example.app.staging`
- `{{LAUNCH_VISIBLE}}` — stable cold-start text, e.g. `Login`
- `{{ASSEMBLE_TASK}}` — e.g. `:app:assembleDebug`
- `{{APK_GLOB}}` — e.g. `app/build/outputs/apk/debug/*.apk`
- `{{PLATFORM}}` — `android` or `ios`
- `{{PR_PATHS}}` — YAML list of path filters for the PR trigger
- `{{RULE_PATH}}` — where the agent-device rule landed (see "Agent rule" below)

---

## `maestro/smoke_launch.yaml`

```yaml
# Launch-only smoke. Tighten selectors after first green run.
appId: {{APP_ID}}
---
- launchApp:
    clearState: true
- extendedWaitUntil:
    visible: "{{LAUNCH_VISIBLE}}"
    timeout: 30000
```

If no stable text yet, use a softer check (prefer tightening ASAP):

```yaml
appId: {{APP_ID}}
---
- launchApp:
    clearState: true
- assertVisible: ".*"
```

---

## `maestro/README.md` (sketch)

```markdown
# Maestro (CI smoke)

appId: `{{APP_ID}}`

## Local

curl -fsSL "https://get.maestro.mobile.dev" | bash
./gradlew {{ASSEMBLE_TASK}}
adb install -r {{APK_GLOB}}
maestro test maestro/smoke_launch.yaml

## CI

`.github/workflows/maestro-smoke.yml` — separate from store deploy.

Agentic / exploratory QA → `docs/agent-device.md` (not new Maestro for every check).
```

---

## `.github/workflows/maestro-smoke.yml` (Android sketch)

```yaml
name: Maestro Android smoke

on:
  workflow_dispatch:
  pull_request:
    paths:
{{PR_PATHS}}

permissions:
  contents: read

concurrency:
  group: maestro-smoke-${{ github.ref }}
  cancel-in-progress: true

jobs:
  smoke:
    name: launch smoke
    runs-on: ubuntu-latest
    timeout-minutes: 60
    steps:
      - uses: actions/checkout@v5
      - uses: actions/setup-java@v5
        with:
          distribution: temurin
          java-version: "17"
          cache: gradle
      - run: chmod +x ./gradlew
      - run: ./gradlew {{ASSEMBLE_TASK}} --stacktrace --no-daemon
      - name: Install Maestro CLI
        run: |
          curl -fsSL "https://get.maestro.mobile.dev" | bash
          echo "$HOME/.maestro/bin" >> "$GITHUB_PATH"
      - name: Enable KVM
        run: |
          echo 'KERNEL=="kvm", GROUP="kvm", MODE="0666", OPTIONS+="static_node=kvm"' | sudo tee /etc/udev/rules.d/99-kvm4all.rules
          sudo udevadm control --reload-rules
          sudo udevadm trigger --name-match=kvm
      - uses: reactivecircus/android-emulator-runner@v2
        with:
          api-level: 34
          arch: x86_64
          profile: pixel_6
          target: google_apis
          cores: 4
          disable-animations: true
          emulator-options: -no-snapshot-save -no-window -gpu swiftshader_indirect -noaudio -no-boot-anim
          script: |
            set -euo pipefail
            APK=$(ls {{APK_GLOB}} | head -n 1)
            adb install -r "$APK"
            maestro test maestro/ --format junit --output maestro-results.xml
      - if: always()
        uses: actions/upload-artifact@v6
        with:
          name: maestro-smoke-results
          path: |
            maestro-results.xml
            ~/.maestro/tests/
          retention-days: 7
          if-no-files-found: ignore
```

---

## `.cursor/mcp.json` merge (Cursor) / `.mcp.json` (Claude Code)

Same `mcpServers` entry in both files. Keep existing servers; add:

```json
"agent-device": {
  "command": "agent-device",
  "args": ["mcp"]
}
```

If binary missing from the agent's PATH, use absolute path from `command -v agent-device`.

---

## Agent rule: `agent-device`

Where it goes: repo has an `.agents/` kit → `.agents/rules/agent-device.md`, then run the
kit's sync. Otherwise `.cursor/rules/agent-device.mdc` (Cursor) and
`.claude/rules/agent-device.md` (Claude Code), same body.

Use Callstack recommended rule from  
https://oss.callstack.com/agent-device/docs/agent-setup#recommended-agent-rule  

Plus project line:

```text
For this app, default target is `{{APP_ID}}` on `--platform {{PLATFORM}}`.
Deterministic CI smoke stays in Maestro (`maestro/`); do not replace Maestro PR checks with ad-hoc agent-device runs.
```

Frontmatter:

```yaml
---
description: Use agent-device for app and device automation
alwaysApply: true
---
```

---

## `docs/agent-device.md` (sketch)

```markdown
# agent-device (local agent QA)

Prereqs: Node ≥ 22.12, Android SDK + adb (or Xcode for iOS), device/emulator.

npm install -g agent-device@latest
agent-device doctor
# optional: npx skills add callstack/agent-device

MCP: `.cursor/mcp.json` (Cursor) / `.mcp.json` (Claude Code) → reconnect MCP.
Rule: {{RULE_PATH}}

## Loop

./gradlew {{ASSEMBLE_TASK}}
adb install -r {{APK_GLOB}}
agent-device boot --platform {{PLATFORM}}
agent-device open {{APP_ID}} --platform {{PLATFORM}} --foreground
# snapshot -i → act → re-snapshot → verify → close
```

Docs: https://oss.callstack.com/agent-device/docs/agent-setup
