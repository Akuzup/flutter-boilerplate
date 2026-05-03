# Flutter Boilerplate

Flutter AI chat application using NVIDIA API (`z-ai/glm4.7` model). Clean Architecture with BLoC state management. Dart SDK ^3.8.0, Material 3 enabled.

## Commands

```bash
# Install dependencies
flutter pub get

# Run code generation (injectable, retrofit, json_serializable)
./gen.sh
# Or equivalently:
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Analyze code
flutter analyze

# Clean iOS (Pods + pub get)
./script-clean-basic.sh

# Deep clean all packages
./script-clean-advance.sh
```

## Architecture

**Layer-first Clean Architecture** under `lib/src/`:

```
lib/
  main.dart                           # Entry point
  src/
    app_delegate.dart                 # Bootstrap orchestrator
    app_coordinator.dart              # Navigation/dialog coordinator
    application.dart                  # Root MaterialApp widget

    core/
      components/                     # Reusable UI widgets
      configurations/                 # Environment config (ChatConfiguration)
      extensions/                     # Dart extensions
      networking/                     # Dio factory, interceptors, ApiResponse, ApiException
      providers/                      # ChatNetworkProvider (Dio + interceptors)
      router/                         # Modular routing (not wired in)
      utils/                          # Utility functions

    data/
      datasource/local/               # SharedPreferences persistence
      datasource/remote/              # Retrofit API clients
      repository/                     # Repository implementations

    domain/
      entities/                       # Business models (Conversation, MessageCompletion)
      repository/                     # Abstract repository interfaces
      usecase/                        # Use cases

    presentations/
      routes.dart                     # onGenerateRoute switch
      dashboard/                      # Bottom nav shell (Chat + Settings tabs)
      chat_list/                      # Conversation list screen
      chat_detail/                    # Chat detail screen
      settings/                       # Settings screen (placeholder)
      shared/dialogs/                 # Shared dialog widgets

    dependency/
      di.dart                         # GetIt + @InjectableInit
      di.config.dart                  # Generated DI config
      modules/                        # DI modules
```

### Dependency Rule

```
Presentation  →  Domain  ←  Data
   (BLoC, UI)    (Entity,    (API, Local
                  UseCase,    Datasource,
                  Repository  Repository
                  interface)  impl)
```

Presentation layer KHÔNG phụ thuộc trực tiếp vào Data layer.

## Key Libraries

| Library | Purpose |
|---------|---------|
| `flutter_bloc` | BLoC state management with sealed events/states |
| `get_it` + `injectable` | Dependency injection (code-generated) |
| `dio` | HTTP client |
| `retrofit` | Type-safe API client generation |
| `shared_preferences` | Local key-value storage |
| `rxdart` | Reactive programming (BehaviorSubject) |

## Chat Feature

- **ChatApi** (`data/datasource/remote/chat_api.dart`) — Retrofit POST to `/chat/completions` on NVIDIA API
- **ChatLocalDatasource** (`data/datasource/local/chat_local_datasource.dart`) — stores conversations as JSON in SharedPreferences
- **ChatRepository** (`domain/repository/`) — abstract interface + impl combining API + local storage
- **ChatUsecase** (`domain/usecase/`) — thin wrapper over repository
- **ChatListBloc** (`@singleton`) — conversation CRUD (load, create, delete)
- **ChatDetailBloc** (per-instance) — message sending with optimistic UI

### API Payload (OpenAI-compatible)

```json
{
  "model": "z-ai/glm4.7",
  "messages": [...],
  "temperature": 1,
  "top_p": 1,
  "max_tokens": 16384
}
```

## Bootstrap Flow

```
main.dart → AppDelegate.run(devEnv) → runZonedGuarded()
  → Configurations.setConfiguration(env)
  → configureDependencies(environment: Environment.prod)
  → runApp(Application(providers: [DashboardBloc, ChatListBloc]))
```

## Routing

`routes.dart` — `onGenerateRoute` switch statement with `MaterialPageRoute`.

- `BlocProvider` được cung cấp trong `routes.dart` (viết trực tiếp, không dùng static helper)
- Screen là plain widget, KHÔNG tự tạo BlocProvider
- Navigation/dialog/bottomsheet phải qua `AppCoordinator` extension trên BuildContext

## Dependency Injection

Three injectable modules in `dependency/modules/`:
- `LocalStorageModule` — SharedPreferences + prod Dio
- `DatesourceModule` — ChatNetworkProvider

Access via `injector.get<T>()`.

## Code Generation

Generated files (`*.g.dart`, `*.freezed.dart`, `di.config.dart`) are excluded from analysis. Always re-run `./gen.sh` after modifying:
- `@injectable`/`@singleton` annotations → regenerates `di.config.dart`
- `@RestApi()` API definitions → regenerates retrofit clients
- `@JsonSerializable()` classes → regenerates serialization code

## Linting

Uses `package:flutter_lints/flutter.yaml` with custom overrides:
- `prefer_relative_imports: true` — always use relative imports
- `prefer_single_quotes: true`
- `avoid_print: true` — use `debugPrint` instead
- `unawaited_futures: true` — must await futures

## Conventions

### Screen Rules
- 1 screen = 1 file (`_screen.dart`), KHÔNG tách screen/view
- 1 folder = 1 screen + 1 BLoC
- Screen chứa `BlocBuilder`/`BlocConsumer` trực tiếp
- KHÔNG viết widget method (`_buildXxx`) — tách ra `widgets/` folder
- KHÔNG tự gọi Navigator/showDialog — phải qua AppCoordinator
- Widget reusable → `core/components/`, utility → `core/extensions/`

### BLoC Rules
- BLoC `@singleton` nếu embedded trong dashboard/tab
- BLoC không annotation nếu tạo mới mỗi lần navigate
- Events/States là `sealed class` (Dart 3)
- State UI tách riêng trong `state_ui/`, có `copyWith()`

### Entity Rules
- Manual `toJson()`/`fromJson()`/`copyWith()`
- KHÔNG dùng freezed

### File Rules
- 1 file = 1 public class
- File không quá 250 lines
- KHÔNG có widget class private (trừ `_XxxState` companion)
