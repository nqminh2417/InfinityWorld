import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:infinity_world/features/device_info/domain/device_info_snapshot.dart';

class DeviceInfoService {
  DeviceInfoService({
    DeviceInfoPlugin? deviceInfoPlugin,
    MethodChannel? androidChannel,
  }) : _deviceInfoPlugin = deviceInfoPlugin ?? DeviceInfoPlugin(),
       _androidChannel = androidChannel ?? _defaultAndroidChannel;

  static const MethodChannel _defaultAndroidChannel = MethodChannel(
    'infinity_world/device_info',
  );

  final DeviceInfoPlugin _deviceInfoPlugin;
  final MethodChannel _androidChannel;

  Future<DeviceInfoSnapshot> load(DeviceInfoDisplayMetrics display) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return DeviceInfoSnapshot.unavailable(
        display,
        fallbackValue: 'Unsupported',
      );
    }

    try {
      return await _loadAndroid(display);
    } catch (_) {
      return DeviceInfoSnapshot.unavailable(display);
    }
  }

  Future<DeviceInfoSnapshot> _loadAndroid(
    DeviceInfoDisplayMetrics display,
  ) async {
    final device = await _tryValue(_deviceInfoPlugin.androidInfo);
    final nativeValues =
        await _tryValue(
          _androidChannel.invokeMapMethod<String, dynamic>('getDeviceInfo'),
        ) ??
        const <String, dynamic>{};

    return DeviceInfoSnapshot(
      sections: [
        DeviceInfoSection(
          title: 'Device',
          rows: [
            DeviceInfoRow(label: 'Model', value: _deviceValue(device?.model)),
            DeviceInfoRow(
              label: 'Manufacturer',
              value: _deviceValue(device?.manufacturer),
            ),
            DeviceInfoRow(label: 'Brand', value: _deviceValue(device?.brand)),
            DeviceInfoRow(label: 'Board', value: _deviceValue(device?.board)),
            DeviceInfoRow(
              label: 'Hardware',
              value: _deviceValue(device?.hardware),
            ),
            DeviceInfoRow(
              label: 'Bootloader',
              value: _deviceValue(device?.bootloader),
            ),
            DeviceInfoRow(label: 'Build ID', value: _deviceValue(device?.id)),
          ],
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
          rows: [
            DeviceInfoRow(
              label: 'Android Version',
              value:
                  device == null
                      ? 'Unavailable'
                      : 'Android ${_deviceValue(device.version.release)}',
            ),
            DeviceInfoRow(
              label: 'API Level',
              value:
                  device == null
                      ? 'Unavailable'
                      : device.version.sdkInt.toString(),
            ),
            DeviceInfoRow(
              label: 'Security Patch Level',
              value: _deviceValue(device?.version.securityPatch),
            ),
            DeviceInfoRow(
              label: 'Java VM',
              value: _nativeValue(nativeValues, 'javaVm'),
            ),
            DeviceInfoRow(
              label: 'OpenGL ES',
              value: _nativeValue(nativeValues, 'openGlEs'),
            ),
            DeviceInfoRow(
              label: 'Kernel Architecture',
              value: _nativeValue(nativeValues, 'kernelArchitecture'),
            ),
            DeviceInfoRow(
              label: 'Kernel Version',
              value: _nativeValue(nativeValues, 'kernelVersion'),
            ),
            DeviceInfoRow(
              label: 'System Uptime',
              value: _formatUptime(nativeValues['uptimeMillis']),
            ),
            DeviceInfoRow(
              label: 'Root Access',
              value: _nativeValue(nativeValues, 'rootAccess'),
            ),
            DeviceInfoRow(
              label: 'Google Play Services',
              value: _nativeValue(nativeValues, 'googlePlayServices'),
            ),
          ],
        ),
        DeviceInfoSection(
          title: 'Memory & Storage',
          rows: [
            DeviceInfoRow(
              label: 'Total RAM',
              value: _formatMegabytes(device?.physicalRamSize),
            ),
            DeviceInfoRow(
              label: 'Available RAM',
              value: _formatMegabytes(device?.availableRamSize),
            ),
            DeviceInfoRow(
              label: 'Internal Storage',
              value: _formatBytes(device?.totalDiskSize),
            ),
            DeviceInfoRow(
              label: 'Available Storage',
              value: _formatBytes(device?.freeDiskSize),
            ),
          ],
        ),
        DeviceInfoSection(
          title: 'Battery',
          rows: [
            DeviceInfoRow(
              label: 'Health',
              value: _nativeValue(nativeValues, 'batteryHealth'),
            ),
            DeviceInfoRow(
              label: 'Level',
              value: _nativeValue(nativeValues, 'batteryLevel'),
            ),
            DeviceInfoRow(
              label: 'Power Source',
              value: _nativeValue(nativeValues, 'batteryPowerSource'),
            ),
            DeviceInfoRow(
              label: 'Status',
              value: _nativeValue(nativeValues, 'batteryStatus'),
            ),
            DeviceInfoRow(
              label: 'Technology',
              value: _nativeValue(nativeValues, 'batteryTechnology'),
            ),
            DeviceInfoRow(
              label: 'Temperature',
              value: _nativeValue(nativeValues, 'batteryTemperature'),
            ),
            DeviceInfoRow(
              label: 'Voltage',
              value: _nativeValue(nativeValues, 'batteryVoltage'),
            ),
            DeviceInfoRow(
              label: 'SOC',
              value: _nativeValue(nativeValues, 'batterySoc'),
            ),
          ],
        ),
      ],
    );
  }

  Future<T?> _tryValue<T>(Future<T> future) async {
    try {
      return await future;
    } catch (_) {
      return null;
    }
  }

  static String _deviceValue(String? value) {
    if (value == null || value.trim().isEmpty || value == 'unknown') {
      return 'Unknown';
    }
    return value;
  }

  static String _nativeValue(Map<String, dynamic> values, String key) {
    final value = values[key];
    if (value == null || value.toString().trim().isEmpty) {
      return 'Unavailable';
    }
    return value.toString();
  }

  static String _formatMegabytes(int? value) {
    if (value == null) {
      return 'Unavailable';
    }
    return '$value MB';
  }

  static String _formatBytes(int? value) {
    if (value == null) {
      return 'Unavailable';
    }

    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = value.toDouble();
    var unitIndex = 0;
    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex += 1;
    }

    final fractionDigits = size >= 10 || unitIndex == 0 ? 0 : 1;
    return '${size.toStringAsFixed(fractionDigits)} ${units[unitIndex]}';
  }

  static String _formatUptime(dynamic value) {
    final milliseconds = switch (value) {
      int value => value,
      num value => value.toInt(),
      _ => null,
    };
    if (milliseconds == null) {
      return 'Unavailable';
    }

    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${hours}h ${minutes}m';
    }
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${minutes}m';
    }
    return '${duration.inMinutes}m';
  }
}
