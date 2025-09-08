# Task Manager (Flutter)

Minimal task manager built with Flutter + Firebase (Auth + Firestore) using a feature-first structure, DI (get_it), and Cubit state management.

 Run:
   - Android: `flutter run -d <android_device>`
   - iOS: open `ios/Runner.xcworkspace` and run, or `flutter run -d <ios_device>`

## Architecture
- Feature-wise folders under `lib/features/*`
- Data: Firestore datasource + repository implementation
- Domain: repository abstractions + simple use cases
- Presentation: Cubits + pages + small widgets
- DI: `lib/injection_container.dart` with get_it
- Routing: AutoRoute with an AuthGuard

## Key Paths
- Auth: `lib/features/auth/*`
- Tasks: `lib/features/task_management/*`
- DI: `lib/injection_container.dart`
- Routes: `lib/routes/app_router.dart`

## Notes
- Offline persistence enabled for Firestore
- Status uses a `TaskStatus` enum (pending/completed)
- Success/error shown via SnackBars


