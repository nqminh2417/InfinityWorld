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
    expect(await repository.getDisplayName(), isNull);
  });

  test('hasSession is false when the display name is missing', () async {
    SharedPreferencesAsyncPlatform
        .instance = InMemorySharedPreferencesAsync.withData({
      LocalSessionRepository.isLoggedInKey: true,
    });
    final repository = LocalSessionRepository();

    expect(await repository.hasSession(), isFalse);
  });

  test('saveSession stores a local session flag and display name', () async {
    final repository = LocalSessionRepository();

    await repository.saveSession(displayName: '  Minh  ');

    expect(await repository.hasSession(), isTrue);
    expect(await repository.getDisplayName(), 'Minh');
  });

  test('saveSession rejects blank display names', () async {
    final repository = LocalSessionRepository();

    expect(
      () => repository.saveSession(displayName: '   '),
      throwsArgumentError,
    );
    expect(await repository.hasSession(), isFalse);
  });

  test(
    'clearSession removes the local session flag and display name',
    () async {
      final repository = LocalSessionRepository();

      await repository.saveSession(displayName: 'Minh');
      await repository.clearSession();

      expect(await repository.hasSession(), isFalse);
      expect(await repository.getDisplayName(), isNull);
    },
  );
}
