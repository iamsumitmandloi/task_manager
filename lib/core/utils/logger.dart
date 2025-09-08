void logInfo(String message) {
  // ignore: avoid_print
  print('[INFO] $message');
}

void logError(String message, [Object? error]) {
  // ignore: avoid_print
  print('[ERROR] $message ${error ?? ''}');
}
