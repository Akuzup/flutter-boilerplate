# Flutter Boilerplate

A comprehensive Flutter boilerplate project implementing Clean Architecture with AI chat integration. This project serves as a production-ready foundation for Flutter applications with modern development practices and scalable architecture.

## 🚀 Features

- **Clean Architecture**: Well-structured codebase following Clean Architecture principles
- **AI Chat Integration**: Built-in integration with YescaleAI for conversational AI features
- **Dependency Injection**: Robust DI system using GetIt and Injectable
- **State Management**: BLoC pattern for predictable state management
- **Multi-platform Support**: iOS, Android, Web, macOS, and Windows
- **Networking**: Type-safe API calls with Retrofit and Dio
- **Local Storage**: SharedPreferences integration for data persistence
- **Supabase Integration**: Backend-as-a-Service integration
- **Modular Architecture**: Separate core package for reusable components

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/src/
├── core/                 # Core configurations and providers
├── data/                 # Data layer (repositories, data sources)
├── domain/               # Domain layer (entities, use cases, repositories)
├── presentations/        # Presentation layer (UI, BLoC, screens)
└── dependency/           # Dependency injection configuration
```

### Architecture Layers

1. **Domain Layer** (`lib/src/domain/`)
   - **Entities**: Core business objects (e.g., `Conversation`, `MessageCompletion`)
   - **Repositories**: Abstract interfaces for data operations
   - **Use Cases**: Business logic and application-specific rules

2. **Data Layer** (`lib/src/data/`)
   - **Repositories**: Concrete implementations of domain repositories
   - **Data Sources**: Remote API clients and local storage handlers
   - **Models**: Data transfer objects and API response models

3. **Presentation Layer** (`lib/src/presentations/`)
   - **Screens**: UI components and pages
   - **BLoC**: State management using BLoC pattern
   - **Widgets**: Reusable UI components

4. **Core Layer** (`lib/src/core/`)
   - **Configurations**: App settings and environment variables
   - **Providers**: Network providers and service configurations

## 📁 Project Structure

```
flutter_boilerplate/
├── lib/
│   ├── main.dart                    # Application entry point
│   └── src/
│       ├── app_delegate.dart        # App initialization and setup
│       ├── application.dart         # Main app widget with providers
│       ├── core/                    # Core configurations
│       │   ├── configurations/      # Environment and app configs
│       │   └── providers/           # Network and service providers
│       ├── data/                    # Data layer implementation
│       │   ├── datasource/          # API clients and data sources
│       │   └── repository/          # Repository implementations
│       ├── domain/                  # Business logic layer
│       │   ├── entities/            # Domain models
│       │   ├── repository/          # Repository interfaces
│       │   └── usecase/             # Business use cases
│       ├── presentations/           # UI layer
│       │   ├── dashboard/           # Dashboard feature
│       │   ├── home/                # Home feature
│       │   ├── settings/            # Settings feature
│       │   └── routes.dart          # App routing configuration
│       └── dependency/              # Dependency injection
│           ├── di.dart              # DI configuration
│           └── modules/             # DI modules
├── packages/
│   └── app_core/                    # Core package for reusable components
│       ├── lib/
│       │   ├── src/
│       │   │   ├── networking/      # HTTP client and interceptors
│       │   │   ├── router/          # Navigation utilities
│       │   │   └── dependency_injection/ # Core DI setup
│       │   └── app_core.dart        # Package exports
│       └── pubspec.yaml
├── android/                         # Android-specific code
├── ios/                             # iOS-specific code
├── web/                             # Web-specific code
├── macos/                           # macOS-specific code
├── windows/                         # Windows-specific code
└── pubspec.yaml                     # Project dependencies
```

## 🛠️ Technologies & Dependencies

### Core Dependencies
- **Flutter SDK**: ^3.8.0
- **Dart**: ^3.8.0

### State Management
- **flutter_bloc**: ^9.1.1 - BLoC pattern implementation
- **rxdart**: ^0.28.0 - Reactive programming utilities

### Dependency Injection
- **get_it**: ^8.0.3 - Service locator
- **injectable**: ^2.5.0 - Code generation for DI

### Networking
- **dio**: ^5.8.0+1 - HTTP client
- **retrofit**: ^4.4.2 - Type-safe API client generation

### Backend Integration
- **supabase_flutter**: ^2.9.0 - Supabase client

### Local Storage
- **shared_preferences**: ^2.5.3 - Key-value storage

### Code Generation
- **freezed**: ^3.0.6 - Immutable classes and unions
- **json_annotation**: ^4.9.0 - JSON serialization
- **build_runner**: ^2.4.15 - Code generation runner

### Development Tools
- **flutter_lints**: ^6.0.0 - Linting rules
- **injectable_generator**: ^2.7.0 - DI code generation
- **retrofit_generator**: ^9.2.0 - API client generation
- **json_serializable**: ^6.9.5 - JSON serialization generation

## 🚦 Getting Started

### Prerequisites
- Flutter SDK (^3.8.0)
- Dart SDK (^3.8.0)
- IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_boilerplate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   cd packages/app_core
   flutter pub get
   cd ../..
   ```

3. **Generate code**
   ```bash
   # Generate dependency injection and API clients
   flutter packages pub run build_runner build --delete-conflicting-outputs

   # Or use the provided script
   chmod +x gen.sh
   ./gen.sh
   ```

4. **Configure environment**
   - Update configuration files in `lib/src/core/configurations/env/`
   - Set your API keys and endpoints in the environment files

5. **Run the application**
   ```bash
   flutter run
   ```

### Environment Configuration

The app supports multiple environments through configuration files:

- `lib/src/core/configurations/env/dev_env.dart` - Development environment
- `lib/src/core/configurations/default_config.dart` - Default configurations

Update these files with your specific API endpoints and keys:

```dart
// Example configuration
class DefaultConfigurations {
  static const String supabaseProjectUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseApiKey = 'YOUR_SUPABASE_KEY';
  static YescaleaiConfiguration yescaleaiConfiguration = YescaleaiConfiguration(
    baseUrl: 'YOUR_AI_API_URL',
    apiKey: 'YOUR_AI_API_KEY',
    enable: true,
  );
}
```

## 🔧 Development Guide

### Adding New Features

1. **Create Domain Layer**
   ```bash
   # Create entity
   lib/src/domain/entities/your_entity.dart

   # Create repository interface
   lib/src/domain/repository/your_repository.dart

   # Create use case
   lib/src/domain/usecase/your_usecase.dart
   ```

2. **Implement Data Layer**
   ```bash
   # Create API client (if needed)
   lib/src/data/datasource/remote/your_api.dart

   # Implement repository
   lib/src/data/repository/your_repository.impl.dart
   ```

3. **Create Presentation Layer**
   ```bash
   # Create BLoC
   lib/src/presentations/your_feature/bloc/your_bloc.dart

   # Create screen
   lib/src/presentations/your_feature/your_screen.dart
   ```

4. **Register Dependencies**
   - Add your dependencies to the appropriate DI module
   - Run code generation: `flutter packages pub run build_runner build`

### Dependency Injection

The project uses **GetIt** with **Injectable** for dependency injection:

#### Key DI Files:
- `lib/src/dependency/di.dart` - Main DI configuration
- `lib/src/dependency/di.config.dart` - Generated DI code
- `lib/src/dependency/modules/` - DI modules for different concerns

#### DI Modules:
- **LocalStorageModule**: SharedPreferences and Dio configuration
- **SupabaseModule**: Supabase client initialization
- **DatasourceModule**: API clients and network providers

#### Usage Example:
```dart
// Register a service
@injectable
class YourService {
  final YourRepository repository;
  YourService({required this.repository});
}

// Inject in widget
final service = injector.get<YourService>();
```

### State Management with BLoC

The project uses **BLoC pattern** for state management:

#### BLoC Structure:
```dart
// Events
abstract class YourEvent extends Equatable {}

// States
abstract class YourState extends Equatable {}

// BLoC
class YourBloc extends Bloc<YourEvent, YourState> {
  final YourUsecase usecase;

  YourBloc({required this.usecase}) : super(YourInitial()) {
    on<YourEvent>(_onYourEvent);
  }
}
```

#### Provider Registration:
```dart
// In app_delegate.dart
BlocProvider<YourBloc>(
  create: (context) => injector.get<YourBloc>(),
),
```

### Networking

The project uses **Dio** with **Retrofit** for type-safe API calls:

#### API Client Example:
```dart
@RestApi()
abstract class YourApi {
  factory YourApi(Dio dio) = _YourApi;

  @POST('/endpoint')
  Future<ApiResponse<YourModel>> yourMethod(
    @Body() Map<String, dynamic> payload,
  );
}
```

#### Network Provider:
- Automatic token injection via `ApiTokenInterceptor`
- Request/response logging via `LoggerInterceptor`
- Error handling with custom exceptions

### Code Generation

The project uses several code generators:

#### Available Scripts:
```bash
# Generate all code
./gen.sh

# Manual generation
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on file changes)
flutter packages pub run build_runner watch
```

#### Generated Files:
- `*.g.dart` - JSON serialization
- `*.freezed.dart` - Immutable classes
- `di.config.dart` - Dependency injection
- API client implementations

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Structure
```
test/
├── unit/           # Unit tests
├── widget/         # Widget tests
└── integration/    # Integration tests
```

### Writing Tests

#### Unit Test Example:
```dart
void main() {
  group('YourUsecase', () {
    late YourUsecase usecase;
    late MockYourRepository mockRepository;

    setUp(() {
      mockRepository = MockYourRepository();
      usecase = YourUsecase(repository: mockRepository);
    });

    test('should return data when repository call is successful', () async {
      // Arrange
      when(mockRepository.getData()).thenAnswer((_) async => testData);

      // Act
      final result = await usecase.getData();

      // Assert
      expect(result, equals(testData));
    });
  });
}
```

## 📱 Platform-Specific Configuration

### Android
- **Minimum SDK**: 21
- **Target SDK**: 34
- **Package**: `com.example.fima`

### iOS
- **Minimum iOS**: 12.0
- **Bundle ID**: Configure in `ios/Runner/Info.plist`

### Web
- **PWA Support**: Configured in `web/manifest.json`
- **Icons**: Available in `web/icons/`

### macOS
- **Minimum macOS**: 10.14
- **Entitlements**: Configured for sandbox and network access

### Windows
- **Minimum Windows**: Windows 10
- **CMake**: Build configuration in `windows/CMakeLists.txt`

## 🔒 Security Considerations

1. **API Keys**: Store sensitive keys in environment variables
2. **Network Security**: HTTPS enforced for all API calls
3. **Token Management**: Automatic token refresh and secure storage
4. **Input Validation**: Validate all user inputs
5. **Error Handling**: Don't expose sensitive information in error messages

## 📚 Additional Resources

### Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Library](https://bloclibrary.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)
- [Injectable Documentation](https://pub.dev/packages/injectable)

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter_lints` for consistent code style
- Run `dart format .` before committing

### Git Workflow
1. Create feature branch from `main`
2. Make changes and commit with descriptive messages
3. Run tests and ensure code generation is up to date
4. Create pull request for review

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library contributors
- GetIt and Injectable package maintainers
- All open-source contributors who made this project possible

---

**Happy Coding! 🚀**
