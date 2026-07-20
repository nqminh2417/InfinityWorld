import 'package:flutter/widgets.dart';

class DeviceInfoSnapshot {
  const DeviceInfoSnapshot({required this.sections});

  final List<DeviceInfoSection> sections;

  factory DeviceInfoSnapshot.loading(DeviceInfoDisplayMetrics display) {
    return DeviceInfoSnapshot._fallback(
      display: display,
      fallbackValue: 'Loading...',
    );
  }

  factory DeviceInfoSnapshot.unavailable(
    DeviceInfoDisplayMetrics display, {
    String fallbackValue = 'Unavailable',
  }) {
    return DeviceInfoSnapshot._fallback(
      display: display,
      fallbackValue: fallbackValue,
    );
  }

  factory DeviceInfoSnapshot._fallback({
    required DeviceInfoDisplayMetrics display,
    required String fallbackValue,
  }) {
    return DeviceInfoSnapshot(
      sections: [
        DeviceInfoSection(
          title: 'Device',
          rows: _rows(<String>[
            'Model',
            'Manufacturer',
            'Brand',
            'Board',
            'Hardware',
            'Bootloader',
            'Build ID',
          ], fallbackValue),
        ),
        DeviceInfoSection(
          title: 'Display',
          rows: [
            DeviceInfoRow(label: 'Screen Size', value: display.logicalSize),
            DeviceInfoRow(
              label: 'Screen Resolution',
              value: display.resolution,
            ),
            DeviceInfoRow(label: 'Screen Density', value: display.density),
          ],
        ),
        DeviceInfoSection(
          title: 'System',
          rows: _rows(<String>[
            'Android Version',
            'API Level',
            'Security Patch Level',
            'Java VM',
            'OpenGL ES',
            'Kernel Architecture',
            'Kernel Version',
            'System Uptime',
            'Root Access',
            'Google Play Services',
          ], fallbackValue),
        ),
        DeviceInfoSection(
          title: 'Memory & Storage',
          rows: _rows(<String>[
            'Total RAM',
            'Available RAM',
            'Internal Storage',
            'Available Storage',
          ], fallbackValue),
        ),
        DeviceInfoSection(
          title: 'Battery',
          rows: _rows(<String>[
            'Health',
            'Level',
            'Power Source',
            'Status',
            'Technology',
            'Temperature',
            'Voltage',
            'SOC',
          ], fallbackValue),
        ),
      ],
    );
  }

  static List<DeviceInfoRow> _rows(List<String> labels, String value) {
    return labels
        .map((label) => DeviceInfoRow(label: label, value: value))
        .toList(growable: false);
  }
}

class DeviceInfoSection {
  const DeviceInfoSection({required this.title, required this.rows});

  final String title;
  final List<DeviceInfoRow> rows;
}

class DeviceInfoRow {
  const DeviceInfoRow({required this.label, required this.value});

  final String label;
  final String value;
}

class DeviceInfoDisplayMetrics {
  const DeviceInfoDisplayMetrics({
    required this.logicalWidth,
    required this.logicalHeight,
    required this.physicalWidth,
    required this.physicalHeight,
    required this.pixelRatio,
  });

  factory DeviceInfoDisplayMetrics.fromMediaQuery(MediaQueryData mediaQuery) {
    return DeviceInfoDisplayMetrics(
      logicalWidth: mediaQuery.size.width,
      logicalHeight: mediaQuery.size.height,
      physicalWidth: mediaQuery.size.width * mediaQuery.devicePixelRatio,
      physicalHeight: mediaQuery.size.height * mediaQuery.devicePixelRatio,
      pixelRatio: mediaQuery.devicePixelRatio,
    );
  }

  final double logicalWidth;
  final double logicalHeight;
  final double physicalWidth;
  final double physicalHeight;
  final double pixelRatio;

  String get logicalSize =>
      '${_formatDimension(logicalWidth)} x ${_formatDimension(logicalHeight)} dp';

  String get resolution =>
      '${_formatDimension(physicalWidth)} x ${_formatDimension(physicalHeight)} px';

  String get density => 'x${pixelRatio.toStringAsFixed(2)}';

  static String _formatDimension(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }
}
