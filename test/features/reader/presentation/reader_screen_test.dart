import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/reader/presentation/reader_screen.dart';

void main() {
  testWidgets('Reader screen renders a scroll-safe local reading sample', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: ReaderScreen()));
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsOneWidget);
    expect(find.text('Reader'), findsOneWidget);
    expect(find.text('The First Door'), findsOneWidget);
    expect(find.text('InfinityWorld sample'), findsOneWidget);
    expect(find.textContaining('first door opened quietly'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
