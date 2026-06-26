import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:infinity_world/screens/fox/models/fox_model.dart';
import 'package:infinity_world/screens/fox/services/fox_api_service.dart';

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
        httpGet: (uri) async {
          requestedUris.add(uri);

          return http.Response(
            '{"image":"https://randomfox.ca/images/1.jpg","link":"https://randomfox.ca/?i=1"}',
            200,
          );
        },
      );

      final fox = await service.getRandomFox();

      expect(requestedUris.single.toString(), 'https://randomfox.ca/floof/');
      expect(fox.image, 'https://randomfox.ca/images/1.jpg');
      expect(fox.link, 'https://randomfox.ca/?i=1');
    });

    test('throws for non-200 responses', () {
      final service = FoxApiService(
        httpGet: (_) async => http.Response('Server error', 500),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });

    test('throws for malformed JSON', () {
      final service = FoxApiService(
        httpGet: (_) async => http.Response('not-json', 200),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });

    test('throws when required response data is missing', () {
      final service = FoxApiService(
        httpGet: (_) async => http.Response('{"link":"missing-image"}', 200),
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });

    test('throws when the request times out', () {
      final service = FoxApiService(
        timeout: Duration.zero,
        httpGet: (_) => Completer<http.Response>().future,
      );

      expect(service.getRandomFox(), throwsA(isA<FoxApiException>()));
    });
  });
}
