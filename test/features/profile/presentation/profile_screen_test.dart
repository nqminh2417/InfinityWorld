import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';
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

  testWidgets(
    'Profile screen remains safe-area and scroll aware on small screens',
    (tester) async {
      await LocalSessionRepository().saveSession(displayName: 'Minh');
      await tester.binding.setSurfaceSize(const Size(360, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ProfileScreen())),
      );
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (widget) => widget is SafeArea && !widget.top && widget.bottom,
        ),
        findsOneWidget,
      );
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(IwCard), findsOneWidget);
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('Minh'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
