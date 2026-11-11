# agency-app-architecture — reference

## MVI skeletons (Kotlin)

```kotlin
// feature/bid/BidContract.kt
sealed interface BidIntent {
  data class DistanceChanged(val km: Double) : BidIntent
  data object Calculate : BidIntent
}

data class BidUiState(
  val km: Double = 0.0,
  val minFare: String = "",
  val goodFare: String = "",
  val stretchFare: String = "",
  val isCalculating: Boolean = false,
)

sealed interface BidUiEffect {
  data class Speak(val text: String) : BidUiEffect
  data class ShowMessage(val message: String) : BidUiEffect
}
```

```kotlin
// feature/bid/BidViewModel.kt — Android ViewModel calling KMP use cases
class BidViewModel(
  private val calculateFloor: CalculateFloorUseCase,
  private val analytics: Analytics,
) : ViewModel() {
  private val _state = MutableStateFlow(BidUiState())
  val state: StateFlow<BidUiState> = _state.asStateFlow()

  private val _effects = Channel<BidUiEffect>(Channel.BUFFERED)
  val effects = _effects.receiveAsFlow()

  fun onIntent(intent: BidIntent) { /* reduce + use cases; never block UI thread incorrectly */ }
}
```

Compose: `collectAsStateWithLifecycle` for state; `LaunchedEffect` to consume effects once.

## Gradle layout sketch

```text
build-logic/
  settings.gradle.kts
  convention/build.gradle.kts
  convention/src/main/kotlin/
    KmpLibraryConventionPlugin.kt
    AndroidApplicationConventionPlugin.kt
    AndroidLibraryConventionPlugin.kt
    ComposeConventionPlugin.kt
    TestingConventionPlugin.kt
```

Register in `build-logic/convention/build.gradle.kts`:

```kotlin
gradlePlugin {
  plugins {
    register("kmpLibrary") {
      id = "com.example.agency.kmp.library"
      implementationClass = "KmpLibraryConventionPlugin"
    }
    register("androidApplication") {
      id = "com.example.agency.android.application"
      implementationClass = "AndroidApplicationConventionPlugin"
    }
    register("androidLibrary") {
      id = "com.example.agency.android.library"
      implementationClass = "AndroidLibraryConventionPlugin"
    }
    register("compose") {
      id = "com.example.agency.compose"
      implementationClass = "ComposeConventionPlugin"
    }
    register("testing") {
      id = "com.example.agency.testing"
      implementationClass = "TestingConventionPlugin"
    }
  }
}
```

Root `settings.gradle.kts` must `includeBuild("build-logic")` and enable `TYPESAFE_PROJECT_ACCESSORS`.

## Dependency direction

```text
androidApp → domain (use cases) → (ports)
androidApp → analytics (API only)
data → domain (implements ports)
data → regionpacks / platform storage
analytics → (nothing in domain)
```

Never: `domain → data`, `domain → android`, `domain → compose`.

## Owned analytics (optional module)

Allowlist events; `NoOpAnalyticsSink` default; redactor; bounded queue; no network until ADR.

## Example product mapping

| Skill default | Example role |
|---------------|--------------|
| `:androidApp` | Compose application module |
| `:core:domain` | Domain models + use cases |
| `:core:data` | Repository impls + local storage |
| `:core:analytics` | Owned analytics SDK (NoOp default) |
| extra | Product-specific cores only when needed |
