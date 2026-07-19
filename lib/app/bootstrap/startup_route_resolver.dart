import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/app/router/app_routes.dart';

Future<String> resolveStartupRoute({
  LocalSessionRepository? sessionRepository,
}) async {
  final repository = sessionRepository ?? LocalSessionRepository();
  return await repository.hasSession() ? AppRoutes.main : AppRoutes.login;
}
