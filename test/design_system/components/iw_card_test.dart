import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/theme/app_theme.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';

void main() {
  testWidgets('IwCard renders content and handles taps', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: IwCard(onTap: () => taps++, child: const Text('Profile card')),
        ),
      ),
    );

    expect(find.text('Profile card'), findsOneWidget);

    await tester.tap(find.byType(IwCard));
    await tester.pump();

    expect(taps, 1);
    expect(tester.takeException(), isNull);
  });
}
