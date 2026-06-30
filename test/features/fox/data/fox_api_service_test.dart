import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/core/network/dio_provider.dart';
import 'package:infinity_world/features/fox/data/fox_api_service.dart';
import 'package:infinity_world/features/fox/domain/fox_model.dart';

void main() {
  group('FoxModel', () {
    test('parses a valid response', () {
      final fox = FoxModel.fromJson({
        'image': 'https://randomfox.ca/images/1.jpg',
        'link': 'https://randomfox.ca/?i=1',
      });

      expect(fox.image, 'https://randomfox.ca/images/1.jpg');
      expect(fox.link, 'https://randomfox.ca/?i=1');
    });

    test('rejects a missing image', () {
      expect(
        () => FoxModel.fromJson({'link': 'https://randomfox.ca/?i=1'}),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects an invalid image URL', () {
      expect(
        () => FoxModel.fromJson({'image': 'not-a-url'}),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('FoxApiService', () {
    test('returns a fox from a valid response', () async {
      final requestedUris = <Uri>[];
      final service = FoxApiService(
        dio: _fakeDio((options) {
          requestedUris.add(options.uri);
          return Future.value(
            _responseBody(
              '{"image":"https://randomfox.ca/images/1.jpg","link":"https://randomfox.ca/?i=1"}',
              200,
            ),
          );
        }),
      );

      final fox = await service.getRandomFox();

      expect(requestedUris.single.toString(), 'https://randomfox.ca/floof/');
      expect(fox.image, 'https://randomfox.ca/images/1.jpg');
      expect(fox.link, 'https://randomfox.ca/?i=1');
    });

    test('throws for non-200 responses', () {
      final service = FoxApiService(
        dio: _fakeDio((_) => Future.value(_responseBody('Server error', 500))),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });

    test('throws for malformed JSON', () {
      final service = FoxApiService(
        dio: _fakeDio((_) => Future.value(_responseBody('not-json', 200))),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });

    test('throws when required response data is missing', () {
      final service = FoxApiService(
        dio: _fakeDio(
          (_) => Future.value(_responseBody('{"link":"missing-image"}', 200)),
        ),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });

    test('throws when the request times out', () {
      final pendingResponse = Completer<ResponseBody>();
      final service = FoxApiService(
        timeout: Duration.zero,
        dio: _fakeDio((_) => pendingResponse.future),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });
  });
}

Dio _fakeDio(Future<ResponseBody> Function(RequestOptions options) fetch) {
  final dio = createDioClient();
  dio.httpClientAdapter = _FakeDioAdapter(fetch);
  return dio;
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
