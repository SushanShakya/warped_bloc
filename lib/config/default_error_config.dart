class DefaultErrorConfig {
  static Future<String?> Function(dynamic)? _onErrorCaught;
  static Future<String?> Function(dynamic) get onErrorCaught {
    return _onErrorCaught ??
        (e) async {
          return null;
        };
  }

  static void configure({
    Future<String?> Function(dynamic)? onErrorCaught,
  }) {
    if (onErrorCaught != null) {
      _onErrorCaught = onErrorCaught;
    }
  }
}
