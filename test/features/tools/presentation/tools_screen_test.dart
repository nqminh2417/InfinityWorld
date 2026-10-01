import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/clock/presentation/clock_screen.dart';
import 'package:infinity_world/features/decision_wheel/presentation/decision_wheel_screen.dart';
import 'package:infinity_world/features/device_info/presentation/device_info_screen.dart';
import 'package:infinity_world/features/random_picker/presentation/random_picker_screen.dart';
import 'package:infinity_world/features/tools/presentation/tools_screen.dart';
import 'package:infinity_world/features/unit_converter/presentation/unit_converter_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/app/router/app_routes.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  testWidgets('Tools screen is scroll-safe on small screens', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: ToolsScreen()));
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsWidgets);
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Clock'), findsOneWidget);
    expect(find.text('Random Picker'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Decision Wheel'), 120);
    expect(find.text('Decision Wheel'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Unit Converter'), 120);
    expect(find.text('Unit Converter'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Device Info'), 120);
    expect(find.text('Device Info'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tools BMI card opens the existing BMI route', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ToolsScreen), findsOneWidget);

    await tester.tap(find.text('BMI Calculator'));
    await tester.pumpAndSettle();

    expect(find.byType(BmiScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tools Clock card opens the Clock route', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ToolsScreen), findsOneWidget);

    await tester.tap(find.text('Clock'));
    await tester.pumpAndSettle();

    expect(find.byType(ClockScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tools Random Picker card opens the Random Picker route', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ToolsScreen), findsOneWidget);

    await tester.ensureVisible(find.text('Random Picker'));
    await tester.tap(find.text('Random Picker'));
    await tester.pumpAndSettle();

    expect(find.byType(RandomPickerScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tools Unit Converter card opens the Unit Converter route', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ToolsScreen), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Unit Converter'), 120);
    await tester.tap(find.text('Unit Converter'));
    await tester.pumpAndSettle();

    expect(find.byType(UnitConverterScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tools Decision Wheel card opens the Decision Wheel route', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ToolsScreen), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Decision Wheel'), 120);
    await tester.tap(find.text('Decision Wheel'));
    await tester.pumpAndSettle();

    expect(find.byType(DecisionWheelScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tools Device Info card opens a grouped Device Info screen', (
    tester,
  ) async {
    const deviceInfoChannel = MethodChannel(
      'dev.fluttercommunity.plus/device_info',
    );
    const nativeDeviceInfoChannel = MethodChannel('infinity_world/device_info');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      deviceInfoChannel,
      (call) async => <String, dynamic>{
        'version': <String, dynamic>{
          'baseOS': null,
          'sdkInt': 35,
          'release': '15',
          'codename': 'REL',
          'incremental': 'test',
          'previewSdkInt': 0,
          'securityPatch': '2026-01-05',
        },
        'board': 'test-board',
        'bootloader': 'test-bootloader',
        'brand': 'InfinityWorld',
        'device': 'test-device',
        'display': 'test-display',
        'fingerprint': 'test-fingerprint',
        'hardware': 'test-hardware',
        'host': 'test-host',
        'id': 'test-build',
        'manufacturer': 'InfinityWorld',
        'model': 'Test phone',
        'product': 'test-product',
        'name': 'Test phone',
        'supported32BitAbis': <String>[],
        'supported64BitAbis': <String>['arm64-v8a'],
        'supportedAbis': <String>['arm64-v8a'],
        'tags': 'release-keys',
        'type': 'user',
        'isPhysicalDevice': false,
        'freeDiskSize': 1024,
        'totalDiskSize': 2048,
        'systemFeatures': <String>[],
        'serialNumber': 'unknown',
        'isLowRamDevice': false,
        'physicalRamSize': 4096,
        'availableRamSize': 2048,
      },
    );
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      nativeDeviceInfoChannel,
      (call) async => <String, dynamic>{
        'javaVm': 'ART',
        'openGlEs': '3.2',
        'kernelArchitecture': 'arm64',
        'kernelVersion': 'test-kernel',
        'uptimeMillis': 60000,
        'rootAccess': 'Not detected (heuristic)',
        'googlePlayServices': 'Installed',
        'batteryHealth': 'Good',
        'batteryLevel': '80%',
        'batteryPowerSource': 'Battery',
        'batteryStatus': 'Discharging',
        'batteryTechnology': 'Li-ion',
        'batteryTemperature': '25.0 C',
        'batteryVoltage': '4000 mV',
        'batterySoc': '80%',
      },
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        deviceInfoChannel,
        null,
      );
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        nativeDeviceInfoChannel,
        null,
      );
    });

    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Device Info'), 120);
    await tester.tap(find.text('Device Info'));
    await tester.pumpAndSettle();

    expect(find.byType(DeviceInfoScreen), findsOneWidget);
    expect(find.text('Device'), findsOneWidget);
    expect(find.text('Display'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
