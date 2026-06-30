import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const iwDefaultNetworkTimeout = Duration(seconds: 10);

Dio createDioClient({Duration timeout = iwDefaultNetworkTimeout}) {
  return Dio(
    BaseOptions(
      connectTimeout: timeout,
      sendTimeout: timeout,
      receiveTimeout: timeout,
    ),
  );
}

final dioProvider = Provider<Dio>((ref) {
  return createDioClient();
});
