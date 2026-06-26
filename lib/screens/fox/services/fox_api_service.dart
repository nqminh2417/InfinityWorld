import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/fox_model.dart';

typedef FoxHttpGet = Future<http.Response> Function(Uri uri);

class FoxApiException implements Exception {
  const FoxApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FoxApiService {
  static final Uri _defaultEndpoint = Uri.parse('https://randomfox.ca/floof/');
  static const _defaultTimeout = Duration(seconds: 10);

  FoxApiService({
    FoxHttpGet? httpGet,
    Duration timeout = _defaultTimeout,
    Uri? endpoint,
  }) : _httpGet = httpGet ?? http.get,
       _timeout = timeout,
       _endpoint = endpoint ?? _defaultEndpoint;

  final FoxHttpGet _httpGet;
  final Duration _timeout;
  final Uri _endpoint;

  Future<FoxModel> getRandomFox() async {
    try {
      final response = await _httpGet(_endpoint).timeout(_timeout);

      if (response.statusCode != 200) {
        throw FoxApiException('Failed to load fox: ${response.statusCode}');
      }

      return _parseResponse(response.body);
    } on FoxApiException {
      rethrow;
    } on TimeoutException {
      throw const FoxApiException('Fox request timed out.');
    } on FormatException catch (error) {
      throw FoxApiException('Invalid fox response: ${error.message}');
    } on Object catch (error) {
      throw FoxApiException('Fox request failed: $error');
    }
  }

  FoxModel _parseResponse(String body) {
    final decoded = json.decode(body);

    if (decoded is! Map) {
      throw const FoxApiException('Invalid fox response.');
    }

    try {
      return FoxModel.fromJson(Map<String, dynamic>.from(decoded));
    } on FormatException {
      rethrow;
    } on Object {
      throw const FoxApiException('Invalid fox response.');
    }
  }
}
