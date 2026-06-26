import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/screens/summertime_saga/models/smts_progress_model.dart';
import 'package:infinity_world/screens/summertime_saga/services/smts_service.dart';
import 'package:infinity_world/screens/summertime_saga/smts_home_screen.dart';

void main() {
  void setSmallScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> pumpScreen(
    WidgetTester tester,
    SmtsProgressLoader loadProgress,
  ) {
    return tester.pumpWidget(
      MaterialApp(
        home: SmtsHomeScreen(loadProgress: loadProgress, logoUrl: ''),
      ),
    );
  }

  testWidgets('shows deterministic loading state without live network', (
    tester,
  ) async {
    setSmallScreen(tester);
    final pendingProgress = Completer<SmtsProgressModel>();

    await pumpScreen(tester, () => pendingProgress.future);
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.takeException(), isNull);

    pendingProgress.complete(_progress());
    await tester.pump();
  });

  testWidgets('renders progress content scroll-safely on a small screen', (
    tester,
  ) async {
    setSmallScreen(tester);

    await pumpScreen(tester, () async => _progress());
    await tester.pump();
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('0.20.16 - 83%'), findsOneWidget);
    expect(find.text('12 Tasks'), findsOneWidget);
    expect(find.text('Art'), findsOneWidget);
    expect(find.text('Audio'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -200));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('shows deterministic error and retry states', (tester) async {
    setSmallScreen(tester);
    var requestCount = 0;
    final retryProgress = Completer<SmtsProgressModel>();

    await pumpScreen(tester, () {
      requestCount++;

      if (requestCount == 1) {
        throw const SmtsServiceException('Progress failed');
      }

      return retryProgress.future;
    });
    await tester.pump();
    await tester.pump();

    expect(find.text('Progress failed'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(requestCount, 1);

    await tester.tap(find.text('Retry'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(requestCount, 2);

    retryProgress.complete(_progress());
    await tester.pump();

    expect(find.text('0.20.16 - 83%'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows incomplete-data error instead of throwing', (
    tester,
  ) async {
    setSmallScreen(tester);

    await pumpScreen(tester, () async => SmtsProgressModel(version: '0.20.16'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Progress data is incomplete.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('does not update state after dispose', (tester) async {
    setSmallScreen(tester);
    final pendingProgress = Completer<SmtsProgressModel>();

    await pumpScreen(tester, () => pendingProgress.future);
    await tester.pump();

    await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
    pendingProgress.complete(_progress());
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

SmtsProgressModel _progress() {
  return SmtsProgressModel(
    version: '0.20.16',
    totals: _totals(closed: 10, working: 2, total: 12, completed: '83'),
    issues: Issues(open: 2, closed: 10, total: 12),
    depts: Depts(
      art: _totals(closed: 1, working: 1, total: 2, completed: '50'),
      posing: _totals(closed: 2, working: 0, total: 2, completed: '100'),
      dialogue: _totals(closed: 3, working: 0, total: 3, completed: '100'),
      code: _totals(closed: 2, working: 1, total: 3, completed: '67'),
      audio: _totals(closed: 2, working: 0, total: 2, completed: '100'),
    ),
  );
}

Totals _totals({
  required int closed,
  required int working,
  required int total,
  required String completed,
}) {
  return Totals(
    totalsNew: 0,
    closed: closed,
    working: working,
    total: total,
    percent: Percent(completed: completed, working: '0'),
  );
}
