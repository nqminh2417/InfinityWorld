import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/screens/auth/login_screen.dart';

void main() {
  testWidgets('app starts on the login screen without framework exceptions', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
