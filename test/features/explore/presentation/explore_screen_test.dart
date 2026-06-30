import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/explore/presentation/explore_screen.dart';
import 'package:infinity_world/routes/app_routes.dart';

void main() {
  testWidgets('Explore screen is scroll-safe on small screens', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: ExploreScreen()));
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsNWidgets(2));
    expect(find.text('Random Fox'), findsOneWidget);
    expect(find.text('Summertime Saga'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Explore Random Fox card opens the existing Fox route', (
    tester,
  ) async {
    await tester.pumpWidget(_exploreApp());

    await tester.tap(find.text('Random Fox'));
    await tester.pumpAndSettle();

    expect(find.text('Fox destination'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Explore Summertime Saga card opens the existing tracker route', (
    tester,
  ) async {
    await tester.pumpWidget(_exploreApp());

    await tester.tap(find.text('Summertime Saga'));
    await tester.pumpAndSettle();

    expect(find.text('Summertime destination'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget _exploreApp() {
  return MaterialApp.router(
    routerConfig: GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const ExploreScreen()),
        GoRoute(
          path: AppRoutes.fox,
          builder: (context, state) => const _Destination('Fox destination'),
        ),
        GoRoute(
          path: AppRoutes.smtsHome,
          builder:
              (context, state) => const _Destination('Summertime destination'),
        ),
      ],
    ),
  );
}

class _Destination extends StatelessWidget {
  const _Destination(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
