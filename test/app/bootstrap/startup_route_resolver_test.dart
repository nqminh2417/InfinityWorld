import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/bootstrap/startup_route_resolver.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/routes/app_routes.dart';
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

  test('resolves Login when no local session exists', () async {
    expect(await resolveStartupRoute(), AppRoutes.login);
  });

  test('resolves Main when a local session exists', () async {
    await LocalSessionRepository().saveSession();

    expect(await resolveStartupRoute(), AppRoutes.main);
  });
}
