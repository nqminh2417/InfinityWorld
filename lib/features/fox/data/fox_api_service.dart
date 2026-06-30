import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:infinity_world/core/network/dio_provider.dart';

import '../domain/fox_model.dart';

class FoxApiException implements Exception {
  const FoxApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FoxApiService {
  static final Uri _defaultEndpoint = Uri.parse('https://randomfox.ca/floof/');
  static const _defaultTimeout = Duration(seconds: 10);

  FoxApiService({Dio? dio, Duration timeout = _defaultTimeout, Uri? endpoint})
    : _dio = dio ?? createDioClient(timeout: timeout),
      _timeout = timeout,
      _endpoint = endpoint ?? _defaultEndpoint;

  final Dio _dio;
  final Duration _timeout;
  final Uri _endpoint;

  Future<FoxModel> getRandomFox() async {
    try {
      final response = await _dio
          .getUri<String>(
            _endpoint,
            options: Options(
              responseType: ResponseType.plain,
              validateStatus: (_) => true,
            ),
          )
          .timeout(_timeout);

      final statusCode = response.statusCode;
      if (statusCode != 200) {
        throw FoxApiException('Failed to load fox: ${statusCode ?? 'unknown'}');
      }

      final body = response.data;
      if (body == null) {
        throw const FoxApiException('Invalid fox response.');
      }

      return _parseResponse(body);
    } on FoxApiException {
      rethrow;
    } on TimeoutException {
      throw const FoxApiException('Fox request timed out.');
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const FoxApiException('Fox request timed out.');
      }

      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        throw FoxApiException('Failed to load fox: $statusCode');
      }

      throw FoxApiException('Fox request failed: ${error.message ?? error}');
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
