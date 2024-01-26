import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gigaturnip/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('sign in', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // await tester.tap(find.byKey(const Key('google')));
      final Finder buttonToTap = find.byKey(const Key('policy'));
      // await tester.dragUntilVisible(
      //   buttonToTap, // what you want to find
      //   find.byType(Column), // widget you want to scroll
      //   const Offset(0, 50), // delta to move
      // );

      await tester.tap(buttonToTap);
      await tester.pumpAndSettle();
    });
  });
}