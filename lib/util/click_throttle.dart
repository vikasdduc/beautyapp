class ClickThrottle {
  static final ClickThrottle _singleton = ClickThrottle._internal();
  factory ClickThrottle() => _singleton;

  ClickThrottle._internal();

  DateTime? _lastClickTime;
  final Duration _throttleDuration =
      const Duration(seconds: 1); // Adjust as needed

  bool shouldProcessClick() {
    final currentTime = DateTime.now();
    if (_lastClickTime == null ||
        currentTime.difference(_lastClickTime!) >= _throttleDuration) {
      _lastClickTime = currentTime;
      return true;
    }
    return false;
  }
}
