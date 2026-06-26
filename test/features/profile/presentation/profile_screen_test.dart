import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';

void main() {
  testWidgets(
    'Profile screen remains safe-area and scroll aware on small screens',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
      await tester.pump();

      expect(
        find.byWidgetPredicate(
          (widget) => widget is SafeArea && !widget.top && widget.bottom,
        ),
        findsOneWidget,
      );
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
