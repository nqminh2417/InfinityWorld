import 'package:timezone/data/latest_10y.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

class ClockTimeFormatter {
  static const String californiaLocationName = 'America/Los_Angeles';

  const ClockTimeFormatter();

  static bool _isInitialized = false;
  static timezone.Location? _californiaLocation;

  String formatDeviceTime(DateTime time) {
    return _formatHms(time);
  }

  String formatCaliforniaTime(DateTime instant) {
    _ensureInitialized();

    final californiaTime = timezone.TZDateTime.from(
      instant,
      _californiaLocation!,
    );

    return _formatHms(californiaTime);
  }

  static void _ensureInitialized() {
    if (!_isInitialized) {
      timezone_data.initializeTimeZones();
      _isInitialized = true;
    }

    _californiaLocation ??= timezone.getLocation(californiaLocationName);
  }

  static String _formatHms(DateTime time) {
    return [
      time.hour,
      time.minute,
      time.second,
    ].map((value) => value.toString().padLeft(2, '0')).join(':');
  }
}
