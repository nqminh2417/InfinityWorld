import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/features/summertime_saga/data/smts_service.dart';

final smtsServiceProvider = Provider<SmtsService>((_) {
  return SmtsService();
});
