import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/library/presentation/library_screen.dart';
import 'package:infinity_world/features/reader/presentation/reader_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';

void main() {
  testWidgets('Library screen is scroll-safe on small screens', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: LibraryScreen()));
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsNWidgets(2));
    expect(find.text('Saved content'), findsOneWidget);
    expect(find.text('Sample Reader'), findsOneWidget);
    expect(find.text('No saved content yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library Reader card opens the Reader route', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.local_library_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(LibraryScreen), findsOneWidget);

    await tester.tap(find.text('Sample Reader'));
    await tester.pumpAndSettle();

    expect(find.byType(ReaderScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
