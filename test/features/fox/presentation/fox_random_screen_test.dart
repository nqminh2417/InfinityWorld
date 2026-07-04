import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/fox/data/fox_api_service.dart';
import 'package:infinity_world/features/fox/domain/fox_model.dart';
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
    final pendingFox = Completer<FoxModel>();

    await tester.pumpWidget(
      MaterialApp(
        home: FoxRandomScreen(
          service: _FakeFoxApiService(() => pendingFox.future),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(FoxRandomScreen), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.takeException(), isNull);

    pendingFox.completeError(const FoxApiException('Failed to load fox: 500'));
    await tester.pump();
  });

  testWidgets('Fox screen shows deterministic error and retry states', (
    tester,
  ) async {
    setSmallScreen(tester);
    var requestCount = 0;
    final retryFox = Completer<FoxModel>();
    final service = _FakeFoxApiService(() {
      requestCount++;

      if (requestCount == 1) {
        return Future.error(const FoxApiException('Failed to load fox: 500'));
      }

      return retryFox.future;
    });

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

    retryFox.completeError(const FoxApiException('Failed to load fox: 500'));
    await tester.pump();
  });
}

class _FakeFoxApiService extends FoxApiService {
  _FakeFoxApiService(this._load);

  final Future<FoxModel> Function() _load;

  @override
  Future<FoxModel> getRandomFox() => _load();
}
