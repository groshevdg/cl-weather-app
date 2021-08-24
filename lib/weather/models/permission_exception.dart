class PermissionException implements Exception {
  PermissionException({this.message});

  final String? message;

  @override
  String toString() {
    if (message != null) {
      return 'Permission error: ${Error.safeToString(message)}';
    }
    return 'Permission error';
  }
}
