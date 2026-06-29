import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';

final localSessionRepositoryProvider = Provider<LocalSessionRepository>((ref) {
  return LocalSessionRepository();
});

final currentDisplayNameProvider = FutureProvider<String?>((ref) {
  return ref.watch(localSessionRepositoryProvider).getDisplayName();
});
