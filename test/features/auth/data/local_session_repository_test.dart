import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  test('hasSession is false when no local session is saved', () async {
    final repository = LocalSessionRepository();

    expect(await repository.hasSession(), isFalse);
  });

  test('saveSession stores a local session flag', () async {
    final repository = LocalSessionRepository();

    await repository.saveSession();

    expect(await repository.hasSession(), isTrue);
  });

  test('clearSession removes the local session flag', () async {
    final repository = LocalSessionRepository();

    await repository.saveSession();
    await repository.clearSession();

    expect(await repository.hasSession(), isFalse);
  });
}
