import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gigaturnip/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        'app UI test',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const ValueKey('google')));
          // await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
        });
  });
}