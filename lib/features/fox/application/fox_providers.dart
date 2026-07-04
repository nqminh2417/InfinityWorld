import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/core/network/dio_provider.dart';
import 'package:infinity_world/features/fox/data/fox_api_service.dart';

final foxApiServiceProvider = Provider<FoxApiService>((ref) {
  return FoxApiService(dio: ref.watch(dioProvider));
});
