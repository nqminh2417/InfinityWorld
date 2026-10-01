import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/device_info/domain/device_info_snapshot.dart';
import 'package:infinity_world/features/device_info/presentation/device_info_screen.dart';

void main() {
  testWidgets(
    'Device Info renders grouped sections and unavailable values safely',
    (tester) async {
      const snapshot = DeviceInfoSnapshot(
        sections: [
          DeviceInfoSection(
            title: 'Device',
            rows: [
              DeviceInfoRow(label: 'Model', value: 'Test phone'),
              DeviceInfoRow(label: 'Board', value: 'Unknown'),
            ],
          ),
          DeviceInfoSection(
            title: 'Display',
            rows: [
              DeviceInfoRow(
                label: 'Screen Resolution',
                value: '1080 x 2400 px',
              ),
            ],
          ),
          DeviceInfoSection(
            title: 'System',
            rows: [DeviceInfoRow(label: 'OpenGL ES', value: 'Unavailable')],
          ),
          DeviceInfoSection(
            title: 'Memory & Storage',
            rows: [DeviceInfoRow(label: 'Total RAM', value: '8192 MB')],
          ),
          DeviceInfoSection(
            title: 'Battery',
            rows: [DeviceInfoRow(label: 'Health', value: 'Good')],
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(home: DeviceInfoScreen(loadInfo: (_) async => snapshot)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Device'), findsOneWidget);
      expect(find.text('Display'), findsOneWidget);
      expect(find.text('System'), findsOneWidget);
      expect(find.text('Memory & Storage'), findsOneWidget);
      expect(find.text('Battery'), findsOneWidget);
      expect(find.text('Test phone'), findsOneWidget);
      expect(find.text('Unknown'), findsOneWidget);
      expect(find.text('Unavailable'), findsOneWidget);
      expect(
        find.byKey(const Key('device-info-section-Battery')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
