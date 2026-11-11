---
name: agency-maestro-testing
description: >
  Agency-global native Maestro E2E skill (Android/iOS Compose/Views/SwiftUI/UIKit).
  Use when writing, reviewing, or debugging Maestro YAML flows; accessibility
  selector contracts; Compose testTagsAsResourceId / Android resource-id /
  iOS accessibilityIdentifier; auth, permissions, alerts, deep links, flaky
  selectors, CI, Maestro Cloud, or Maestro MCP write-run-fix loops. Prefer this
  for flow authoring on any mobile git repo. Pair with agency-mobile-test-setup
  for scaffolding and the Maestro MCP for live runs. Skip   for RN/Expo unless
  user says so; skip unit-test-only / pure web Playwright (use agency-playwright-testing).
disable-model-invocation: false
---

# Agency Maestro testing (native)

**Agency kit skill** — installed for every agent (Cursor, Claude Code, Codex, Gemini, …) at `~/.agents/skills/agency-maestro-testing`.

Adapted from [AndyChangTW/maestro-native-mobile-testing-skill](https://github.com/AndyChangTW/maestro-native-mobile-testing-skill) (MIT; original author tovimx / AndyChangTW).

## Agency wiring (read first)

| Layer | Skill / tool |
|-------|----------------|
| Scaffold `maestro/` + CI + agent-device | `agency-mobile-test-setup` |
| Author / debug native YAML flows | **this skill** (`agency-maestro-testing`) |
| Live device run / inspect | Maestro MCP — **`user-maestro`** in Cursor, `mcp__maestro__*` in Claude Code (`list_devices`, `inspect_screen`, `run`, …) |

1. Route substantive repo work via `agency-project-gateway`.
2. Discover **this** app’s `appId` / bundle id — never copy another project’s ids.
3. Call `cheat_sheet` / `list_devices` on the Maestro MCP before inventing unfamiliar Maestro commands.
4. Prefer `id` selectors; use Maestro MCP write → run → fix loop.

---

# Maestro Native Mobile Testing

## Overview

Use this skill to produce stable Maestro E2E tests for native iOS and Android apps. Focus on native accessibility identity, deterministic state setup, traceable assertions, and YAML flows that survive localization, dynamic data, and platform differences.

This skill is native-first. Do not use React Native `testID` or Expo-specific patterns unless the user explicitly says the app is React Native or Expo.

## Workflow

1. Identify the app platform, UI framework, bundle/package id, target state, existing `.maestro` files, and any reviewed UAT Scenario or Accessibility Contract.
2. If a reviewed UAT Scenario exists, preserve its acceptance scope. Do not invent new business assertions.
3. If an Accessibility Contract exists, use only confirmed or implemented selectors. If required selectors are missing, propose native code changes before writing executable YAML.
4. Choose selectors with the policy below, then write one flow per main scenario. Put optional setup branches in subflows.
5. Add waits for stable screen/state markers instead of sleeps or incidental copy.
6. Validate syntax and, when tools are available, run the flow or use Maestro MCP for a write-run-fix loop.

Use this after `clickup-uat-scenario` and `uat-maestro-workflow` when those artifacts are available. Use it directly when the user already asks for native Maestro YAML, selector implementation, or Maestro debugging.

## Selector Policy

- Prefer Maestro `id` selectors for taps, inputs, icons, repeated cells, dynamic content, localized UI, and wait markers.
- Use `text` selectors for system dialogs, exact-copy acceptance checks, and stable single-locale UI where user-visible wording is intentionally under test.
- Avoid `point` selectors except as a last resort for controls outside the accessibility tree. If a point selector is needed, document the native accessibility gap.
- Avoid `index` unless a stable container or row selector narrows the target first.
- For repeated rows, use deterministic ids such as `mission.ranking.row.{rank}.name` or `book.search.result.{book_id}.borrowButton`.
- For async transitions, add a dedicated screen/state marker such as `home.loaded`, `auth.stateLoaded`, or `ranking.list.loaded`.
- Keep accessibility identity separate from accessibility meaning. On iOS, do not replace real `accessibilityLabel`, traits, hints, or VoiceOver semantics just to satisfy tests.

Maestro selector mapping:

| Maestro selector | iOS native | Android native |
|---|---|---|
| `id` | `accessibilityIdentifier` | resource id; for Compose, test tags exposed as resource ids |
| `text` | visible text or `accessibilityLabel` | visible text or `contentDescription` |
| state selectors | accessibility state when exposed | view/accessibility state when exposed |

## iOS Native Patterns

SwiftUI:

```swift
Button("Login") {
    viewModel.login()
}
.accessibilityIdentifier("login.submitButton")

Text(viewModel.title)
    .accessibilityIdentifier("home.title")

Color.clear
    .frame(width: 1, height: 1)
    .accessibilityElement()
    .accessibilityIdentifier("auth.stateLoaded")
```

UIKit:

```swift
loginButton.accessibilityIdentifier = "login.submitButton"
titleLabel.accessibilityIdentifier = "home.title"

let markerView = UIView()
markerView.backgroundColor = .clear
markerView.isAccessibilityElement = true
markerView.accessibilityIdentifier = "auth.stateLoaded"
markerView.isUserInteractionEnabled = false
```

iOS rules:

- Do not set wait markers to `isHidden = true`, `alpha = 0`, or off-screen positions if Maestro must find them.
- Use `accessibilityIdentifier` for automation identity and `accessibilityLabel` for VoiceOver/user meaning.
- Be careful with SwiftUI wrappers: the modifier must be attached to the element Maestro should target, not only to a parent that has no accessibility element.
- For SwiftUI lists, put stable ids on both row containers and row actions when the row has multiple tappable controls.
- Do not rely on `clearState` to reset Keychain-backed auth. Add explicit logout, test-only reset hooks, or adaptive auth flows.

## Android Native Patterns

Android Views:

```xml
<Button
    android:id="@+id/login_submit_button"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="@string/login" />
```

```kotlin
binding.loginSubmitButton.contentDescription = getString(R.string.login)
```

Jetpack Compose:

```kotlin
Column(
    modifier = Modifier.semantics {
        testTagsAsResourceId = true
    }
) {
    Button(
        modifier = Modifier.testTag("login_submit_button"),
        onClick = viewModel::login
    ) {
        Text(stringResource(R.string.login))
    }
}
```

Android rules:

- Prefer real `android:id` for View-based screens.
- For Compose screens, set `testTagsAsResourceId = true` high enough in the semantics tree and use `Modifier.testTag(...)` on the target node.
- Verify the exact id shape with Maestro Studio, `maestro hierarchy`, or Maestro MCP `inspect_view_hierarchy`; projects may expose either short ids or fully qualified resource ids.
- Keep `contentDescription` meaningful for accessibility. Do not use content descriptions as hidden test ids unless the element is genuinely described that way for users.
- Avoid selectors tied to localized strings unless wording is part of the acceptance criteria.

## YAML Flow Rules

Use the standard two-part Maestro file shape:

```yaml
appId: com.example.app
name: Login happy path
tags:
  - smoke
  - native
---
- launchApp:
    clearState: false
    permissions:
      all: deny
      notifications: allow

- extendedWaitUntil:
    visible:
      id: "auth.stateLoaded"
    timeout: 10000

- runFlow:
    when:
      visible:
        id: "login.submitButton"
    file: flows/login.yaml

- assertVisible:
    id: "home.loaded"
```

YAML rules:

- Keep `appId`, `name`, `tags`, and optional `env` above `---`; commands go below `---`.
- Prefer `extendedWaitUntil` for longer native startup, auth restore, sync, or post-navigation waits.
- Do not use fixed sleeps unless diagnosing. Replace them with a visible marker, enabled state, or destination assertion.
- Use `runFlow.when` only for accepted optional setup branches such as first-run prompts, guest/login state, or permission education screens.
- Keep assertions traceable to UAT expected results or the Accessibility Contract.
- Use platform tags such as `ios`, `android`, `smoke`, `regression`, `wip`, and `ci` when flows are platform-specific or CI-filtered.

## Auth And State

Native auth is often restored asynchronously from Keychain, Keystore, encrypted storage, cookies, or account services. Always wait for app auth resolution before deciding whether to log in.

Recommended pattern:

```yaml
- launchApp:
    clearState: false

- extendedWaitUntil:
    visible:
      id: "auth.stateLoaded"
    timeout: 10000

- runFlow:
    when:
      visible:
        id: "login.submitButton"
    file: flows/login.yaml
```

Rules:

- If login is not under test, prefer a seeded authenticated state or adaptive login subflow.
- If login is under test, avoid hidden dependency on previous sessions; define test account, OTP/magic-link retrieval, and expected post-login marker.
- Do not assume `clearState` clears Keychain, system accounts, push permission state, or all server sessions.
- For destructive test data, use unique names or server-side reset hooks rather than relying on UI cleanup.

## Permissions, Alerts, And Deep Links

Permissions:

```yaml
- launchApp:
    permissions:
      all: deny
      camera: allow
      location: inuse

- setPermissions:
    permissions:
      notifications: allow
```

System dialogs:

- Use text selectors because native system alerts do not expose app-defined ids.
- Keep platform-specific dialog copy in separate tagged flows when iOS and Android wording differs.
- Prefer permission configuration when the permission state is setup, and explicit dialog interaction when the dialog behavior is the scenario under test.

Deep links:

```yaml
- openLink: "myapp://mission/ranking"
- extendedWaitUntil:
    visible:
      id: "mission.ranking.loaded"
    timeout: 10000
```

Rules:

- Use iOS URL schemes, universal links, Android app links, or Android intent links that the native app actually handles.
- Assert the destination marker after opening the link; do not stop at the link command.

## Suggested File Structure

```text
.maestro/
|-- config.yaml
|-- smoke/
|   `-- login-happy-path.yaml
|-- regression/
|   `-- mission-ranking.yaml
|-- flows/
|   |-- login.yaml
|   |-- dismiss-first-run.yaml
|   `-- grant-required-permissions.yaml
`-- contracts/
    `-- mission-ranking-accessibility-contract.yaml
```

For nested folders, configure discovery in `.maestro/config.yaml`:

```yaml
flows:
  - smoke/**/*.yaml
  - regression/**/*.yaml
```

## Debugging Loop

When a flow fails:

1. Inspect the view hierarchy before changing YAML. Confirm whether the expected `id`, text, or state exists.
2. If the element is missing from the accessibility tree, fix native accessibility first.
3. If the element exists but is not ready, add or improve a state marker or enabled-state wait.
4. If the selector is ambiguous, add a stable row/container id or relational selector anchored to confirmed content.
5. Re-run the smallest failing flow before broad regression runs.

With Maestro MCP available, use `inspect_view_hierarchy`, `take_screenshot`, `check_flow_syntax`, and `run_flow_files` for the write-run-fix loop.

## Quality Checklist

Before handing off a native Maestro flow, verify:

- The flow uses native selector ids, not React Native `testID` instructions.
- Required selectors are confirmed or explicitly proposed as native code changes.
- Assertions trace back to UAT expected results or the Accessibility Contract.
- Auth/loading state has a deterministic marker.
- Permission state is intentionally configured or intentionally tested.
- System dialogs use text selectors and are platform-aware.
- Dynamic or repeated content has stable row/action ids.
- No fixed sleeps, point selectors, or index selectors are used without explanation.
- The flow can run independently from a clean simulator/emulator state or documents its required seeded state.

## Attribution

Adapted from `tovimx/maestro-mobile-testing-skill`, whose `SKILL.md` declares `license: MIT` and `author: tovimx`. This native version rewrites the guidance for SwiftUI, UIKit, Android Views, and Jetpack Compose.
