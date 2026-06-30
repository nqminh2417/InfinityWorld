import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/core/network/dio_provider.dart';
import 'package:infinity_world/features/summertime_saga/data/smts_service.dart';
import 'package:infinity_world/features/summertime_saga/domain/smts_progress_model.dart';

void main() {
  group('SmtsService', () {
    test('uses configured progress URL and parses a valid response', () async {
      final requestedUris = <Uri>[];
      final service = SmtsService(
        dio: _fakeDio((options) {
          requestedUris.add(options.uri);
          return Future.value(_responseBody(_validProgressJson, 200));
        }),
      );

      final progress = await service.fetchProgress();

      expect(requestedUris, <Uri>[Cfg.smtsProgressUri]);
      expect(progress.version, '0.20.16');
      expect(progress.totals?.closed, 10);
      expect(progress.depts?.art?.percent?.completed, '50');
    });

    test('throws a service exception for non-success status codes', () async {
      final service = SmtsService(
        dio: _fakeDio((_) => Future.value(_responseBody('Server error', 500))),
      );

      await expectLater(
        service.fetchProgress(),
        throwsA(
          isA<SmtsServiceException>().having(
            (error) => error.message,
            'message',
            contains('500'),
          ),
        ),
      );
    });

    test('throws a service exception for malformed JSON', () async {
      final service = SmtsService(
        dio: _fakeDio((_) => Future.value(_responseBody('not json', 200))),
      );

      await expectLater(
        service.fetchProgress(),
        throwsA(
          isA<SmtsServiceException>().having(
            (error) => error.message,
            'message',
            contains('Invalid progress response'),
          ),
        ),
      );
    });

    test('throws a service exception for missing required schema', () async {
      final service = SmtsService(
        dio: _fakeDio(
          (_) => Future.value(_responseBody('{"version":"0.20.16"}', 200)),
        ),
      );

      await expectLater(
        service.fetchProgress(),
        throwsA(
          isA<SmtsServiceException>().having(
            (error) => error.message,
            'message',
            contains('Invalid progress response'),
          ),
        ),
      );
    });

    test('throws a service exception when the request times out', () async {
      final pendingResponse = Completer<ResponseBody>();
      final service = SmtsService(
        dio: _fakeDio((_) => pendingResponse.future),
        timeout: const Duration(milliseconds: 5),
      );

      await expectLater(
        service.fetchProgress(),
        throwsA(
          isA<SmtsServiceException>().having(
            (error) => error.message,
            'message',
            contains('timed out'),
          ),
        ),
      );
    });
  });

  group('SmtsProgressModel', () {
    test('rejects non-object JSON responses', () {
      expect(
        () => SmtsProgressModel.fromJson('[]'),
        throwsA(isA<FormatException>()),
      );
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

const _validProgressJson = '''
{
  "version": "0.20.16",
  "totals": {
    "totalsNew": 0,
    "closed": 10,
    "working": 2,
    "total": 12,
    "percent": {
      "completed": "83",
      "working": "17"
    }
  },
  "issues": {
    "open": 2,
    "closed": 10,
    "total": 12
  },
  "depts": {
    "art": {
      "totalsNew": 0,
      "closed": 1,
      "working": 1,
      "total": 2,
      "percent": {
        "completed": "50",
        "working": "50"
      }
    },
    "posing": {
      "totalsNew": 0,
      "closed": 2,
      "working": 0,
      "total": 2,
      "percent": {
        "completed": "100",
        "working": "0"
      }
    },
    "dialogue": {
      "totalsNew": 0,
      "closed": 3,
      "working": 0,
      "total": 3,
      "percent": {
        "completed": "100",
        "working": "0"
      }
    },
    "code": {
      "totalsNew": 0,
      "closed": 2,
      "working": 1,
      "total": 3,
      "percent": {
        "completed": "67",
        "working": "33"
      }
    },
    "audio": {
      "totalsNew": 0,
      "closed": 2,
      "working": 0,
      "total": 2,
      "percent": {
        "completed": "100",
        "working": "0"
      }
    }
  }
}
''';
