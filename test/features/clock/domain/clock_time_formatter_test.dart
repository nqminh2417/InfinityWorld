import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/clock/domain/clock_time_formatter.dart';

void main() {
  final formatter = ClockTimeFormatter();

  test('formats device local time as HH:mm:ss', () {
    final time = DateTime(2026, 7, 3, 9, 8, 7);

    expect(formatter.formatDeviceTime(time), '09:08:07');
  });

  test('formats California time with daylight saving rules', () {
    expect(
      formatter.formatCaliforniaTime(DateTime.utc(2026, 1, 1, 12, 0, 5)),
      '04:00:05',
    );
    expect(
      formatter.formatCaliforniaTime(DateTime.utc(2026, 7, 1, 12, 0, 5)),
      '05:00:05',
    );
  });
}
