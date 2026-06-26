import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';

void main() {
  testWidgets('Dashboard screen remains scroll-safe on small screens', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));
    await tester.pump();

    expect(find.byType(SafeArea), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(5));
    expect(tester.takeException(), isNull);
  });
}
