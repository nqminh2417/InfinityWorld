import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/core/network/dio_provider.dart';
import 'package:infinity_world/features/summertime_saga/application/smts_providers.dart';
import 'package:infinity_world/features/summertime_saga/data/smts_service.dart';

void main() {
  test('uses the shared Dio provider for progress requests', () async {
    final requestedUris = <Uri>[];
    final dio =
        Dio()
          ..httpClientAdapter = _FakeDioAdapter((options) {
            requestedUris.add(options.uri);
            return Future.value(_responseBody('Unavailable', 500));
          });
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(dio)],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(smtsServiceProvider).fetchProgress(),
      throwsA(isA<SmtsServiceException>()),
    );

    expect(requestedUris, <Uri>[Cfg.smtsProgressUri]);
  });
}

ResponseBody _responseBody(String body, int statusCode) {
  return ResponseBody.fromString(
    body,
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

class _FakeDioAdapter implements HttpClientAdapter {
  const _FakeDioAdapter(this._fetch);

  final Future<ResponseBody> Function(RequestOptions options) _fetch;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _fetch(options);
  }

  @override
  void close({bool force = false}) {}
}
