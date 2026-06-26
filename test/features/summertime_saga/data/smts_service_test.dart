import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/features/summertime_saga/data/smts_service.dart';
import 'package:infinity_world/features/summertime_saga/domain/smts_progress_model.dart';

void main() {
  group('SmtsService', () {
    test('uses configured progress URL and parses a valid response', () async {
      final requestedUris = <Uri>[];
      final service = SmtsService(
        httpGet: (uri) async {
          requestedUris.add(uri);
          return http.Response(_validProgressJson, 200);
        },
      );

      final progress = await service.fetchProgress();

      expect(requestedUris, <Uri>[Cfg.smtsProgressUri]);
      expect(progress.version, '0.20.16');
      expect(progress.totals?.closed, 10);
      expect(progress.depts?.art?.percent?.completed, '50');
    });

    test('throws a service exception for non-success status codes', () async {
      final service = SmtsService(
        httpGet: (_) async => http.Response('Server error', 500),
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
        httpGet: (_) async => http.Response('not json', 200),
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
        httpGet: (_) async => http.Response('{"version":"0.20.16"}', 200),
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
      final pendingResponse = Completer<http.Response>();
      final service = SmtsService(
        httpGet: (_) => pendingResponse.future,
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
