import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:infinity_world/features/fox/data/fox_api_service.dart';
import 'package:infinity_world/features/fox/presentation/fox_random_screen.dart';

void main() {
  void setSmallScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('Fox screen stays scroll-safe in a deterministic loading state', (
    tester,
  ) async {
    setSmallScreen(tester);
    final pendingResponse = Completer<http.Response>();

    await tester.pumpWidget(
      MaterialApp(
        home: FoxRandomScreen(
          service: FoxApiService(httpGet: (_) => pendingResponse.future),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(FoxRandomScreen), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.takeException(), isNull);

    pendingResponse.complete(http.Response('Server error', 500));
    await tester.pump();
  });

  testWidgets('Fox screen shows deterministic error and retry states', (
    tester,
  ) async {
    setSmallScreen(tester);
    var requestCount = 0;
    final retryResponse = Completer<http.Response>();
    final service = FoxApiService(
      httpGet: (_) {
        requestCount++;

        if (requestCount == 1) {
          return Future.value(http.Response('Server error', 500));
        }

        return retryResponse.future;
      },
    );

    await tester.pumpWidget(
      MaterialApp(home: FoxRandomScreen(service: service)),
    );
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Failed to load fox: 500'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(requestCount, 1);

    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(requestCount, 2);
    expect(tester.takeException(), isNull);

    retryResponse.complete(http.Response('Server error', 500));
    await tester.pump();
  });
}
