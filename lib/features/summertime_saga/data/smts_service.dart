import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/features/summertime_saga/domain/smts_progress_model.dart';

typedef SmtsHttpGet = Future<http.Response> Function(Uri uri);

class SmtsServiceException implements Exception {
  const SmtsServiceException(this.message);

  final String message;

  @override
  String toString() => 'SmtsServiceException: $message';
}

class SmtsService {
  SmtsService({SmtsHttpGet? httpGet, Duration timeout = _defaultTimeout})
    : _httpGet = httpGet ?? http.get,
      _timeout = timeout;

  static const Duration _defaultTimeout = Duration(seconds: 15);

  final SmtsHttpGet _httpGet;
  final Duration _timeout;

  static Future<SmtsProgressModel> getProgress() {
    return SmtsService().fetchProgress();
  }

  Future<SmtsProgressModel> fetchProgress() async {
    final http.Response response;

    try {
      response = await _httpGet(Cfg.smtsProgressUri).timeout(_timeout);
    } on TimeoutException {
      throw const SmtsServiceException('Progress request timed out');
    } catch (error) {
      throw SmtsServiceException('Failed to load progress: $error');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw SmtsServiceException(
        'Failed to load progress: ${response.statusCode}',
      );
    }

    try {
      return SmtsProgressModel.fromJson(response.body);
    } on FormatException catch (error) {
      throw SmtsServiceException('Invalid progress response: ${error.message}');
    } on TypeError {
      throw const SmtsServiceException('Invalid progress response shape');
    }
  }
}
