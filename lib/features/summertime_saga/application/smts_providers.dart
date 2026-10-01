import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/core/network/dio_provider.dart';
import 'package:infinity_world/features/summertime_saga/data/smts_service.dart';

final smtsServiceProvider = Provider<SmtsService>((ref) {
  return SmtsService(dio: ref.watch(dioProvider));
});
