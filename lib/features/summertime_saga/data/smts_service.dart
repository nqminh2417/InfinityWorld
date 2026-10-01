import 'dart:async';

import 'package:dio/dio.dart';
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/features/summertime_saga/domain/smts_progress_model.dart';

class SmtsServiceException implements Exception {
  const SmtsServiceException(this.message);

  final String message;

  @override
  String toString() => 'SmtsServiceException: $message';
}

class SmtsService {
  SmtsService({required Dio dio, Duration timeout = _defaultTimeout})
    : _dio = dio,
      _timeout = timeout;

  static const Duration _defaultTimeout = Duration(seconds: 15);

  final Dio _dio;
  final Duration _timeout;

  Future<SmtsProgressModel> fetchProgress() async {
    final Response<String> response;

    try {
      response = await _dio
          .getUri<String>(
            Cfg.smtsProgressUri,
            options: Options(
              responseType: ResponseType.plain,
              validateStatus: (_) => true,
            ),
          )
          .timeout(_timeout);
    } on TimeoutException {
      throw const SmtsServiceException('Progress request timed out');
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const SmtsServiceException('Progress request timed out');
      }

      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        throw SmtsServiceException('Failed to load progress: $statusCode');
      }

      throw SmtsServiceException(
        'Failed to load progress: ${error.message ?? error}',
      );
    } on Object catch (error) {
      throw SmtsServiceException('Failed to load progress: $error');
    }

    final statusCode = response.statusCode;
    if (statusCode == null || statusCode < 200 || statusCode >= 300) {
      throw SmtsServiceException(
        'Failed to load progress: ${statusCode ?? 'unknown'}',
      );
    }

    try {
      final body = response.data;
      if (body == null) {
        throw const FormatException('Progress response is empty');
      }

      return SmtsProgressModel.fromJson(body);
    } on FormatException catch (error) {
      throw SmtsServiceException('Invalid progress response: ${error.message}');
    } on TypeError {
      throw const SmtsServiceException('Invalid progress response shape');
    }
  }
}
