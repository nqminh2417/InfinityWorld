import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/clock/presentation/clock_screen.dart';
import 'package:infinity_world/features/random_picker/presentation/random_picker_screen.dart';
import 'package:infinity_world/features/tools/presentation/tools_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';
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
    expect(find.byType(IwCard), findsNWidgets(3));
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Clock'), findsOneWidget);
    expect(find.text('Random Picker'), findsOneWidget);
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
}
