import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colorizer/main.dart';

void main() {
  testWidgets('Onboarding Test', (WidgetTester tester) async {
    await tester.pumpWidget(ColorizerApp());

    await tester.tap(
      find.byKey(Key('Onboarding Button')),
    );
    // expect(find.text('tapped'), findsOneWidget);
    await tester.pump();
  });
}
