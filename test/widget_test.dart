import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pivo_aula/core/design_system/components/pressable_scale.dart';
import 'package:pivo_aula/core/design_system/components/app_button.dart';

void main() {
  testWidgets('AppButton renders and handles tap', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Test Button',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
    await tester.tap(find.text('Test Button'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('PressableScale wraps child correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PressableScale(
            child: Text('Pressable content'),
          ),
        ),
      ),
    );

    expect(find.text('Pressable content'), findsOneWidget);
  });
}
