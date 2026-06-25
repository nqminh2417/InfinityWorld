import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:infinity_world/routes/app_pages.dart';
import 'package:infinity_world/routes/app_routes.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';

void main() {
  tearDown(() {
    Get.reset();
  });

  testWidgets('settings route opens the existing settings screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppRoutes.settings,
        getPages: AppPages.pages,
      ),
    );

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
