# Task Manager (Flutter)

Minimal task manager built with Flutter + Firebase (Auth + Firestore) using a feature-first structure, DI (get_it), and Cubit state management.

 Run:
   - Android: `flutter run -d <android_device>`
   - iOS: open `ios/Runner.xcworkspace` and run, or `flutter run -d <ios_device>`

## Prerequisites for running the app
- Flutter 3.32.x
- Firebase project (created via FlutterFire)
- Android/iOS toolchains

## Setup
1) Install dependencies:
   - `flutter pub get`
2) Configure Firebase:
   - `dart pub global activate flutterfire_cli`
   - `flutterfire configure` (select your project; include Android/iOS)
   - For Android debug builds, add SHA-1 and SHA-256 to Firebase console and re-download `google-services.json`.
   - Ensure Firestore API is enabled in Google Cloud Console.
3) Run:
   - Android: `flutter run -d <android_device>`
   - iOS: open `ios/Runner.xcworkspace` and run, or `flutter run -d <ios_device>`

## Architecture
- **Feature-first**: `lib/features/{auth,task_management}/`
- **Clean layers**: `data/`, `domain/`, `presentation/`
- **DI**: `lib/injection_container.dart` (get_it)
- **State**: Cubit (flutter_bloc)
- **Routing**: AutoRoute
- **Backend**: Firebase (Auth + Firestore, offline-first)
- **Success/error shown via SnackBars

## Folder Structure
```
lib/
├── core/                           # Shared utilities
│   ├── constants/                  # App constants
│   ├── errors/                     # Custom exceptions
│   └── utils/                      # Logger, validators
├── features/                       # Feature modules
│   ├── auth/                       # Authentication feature
│   │   ├── data/                   # Data layer
│   │   │   ├── datasources/        # Firebase Auth
│   │   │   ├── models/             # User model
│   │   │   └── repositories/       # Auth repo impl
│   │   ├── domain/                 # Domain layer
│   │   │   ├── entities/           # User entity
│   │   │   ├── repositories/       # Auth repo interface
│   │   │   └── usecases/           # Sign in/up/out
│   │   └── presentation/           # UI layer
│   │       ├── cubit/              # Auth state
│   │       ├── pages/              # Auth page
│   │       └── widgets/            # Auth widgets
│   └── task_management/            # Task management feature
│       ├── data/                   # Data layer
│       │   ├── datasources/        # Firestore
│       │   ├── models/             # Task model
│       │   └── repositories/       # Task repo impl
│       ├── domain/                 # Domain layer
│       │   ├── entities/           # Task entity, status
│       │   ├── repositories/       # Task repo interface
│       │   └── usecases/           # CRUD operations
│       └── presentation/           # UI layer
│           ├── cubit/              # Task state
│           ├── pages/              # Task list page
│           └── widgets/            # Task widgets
├── routes/                         # AutoRoute config
└── injection_container.dart        # Dependency injection
```
