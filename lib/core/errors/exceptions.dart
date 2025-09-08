
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message';
}


class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}


class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}


class LocalStorageException extends AppException {
  const LocalStorageException(super.message, [super.code]);
}
