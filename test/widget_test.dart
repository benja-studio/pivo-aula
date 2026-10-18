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

  testWidgets('PressableScale uses the tap gesture for activation',
      (WidgetTester tester) async {
    var tapCount = 0;
    var longPressCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PressableScale(
              onTap: () => tapCount++,
              onLongPress: () => longPressCount++,
              child: const Text('Interactive card'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Interactive card'));
    await tester.pumpAndSettle();

    expect(tapCount, 1);
    expect(longPressCount, 0);
  });

  testWidgets('PressableScale does not dispatch a tap after a long press',
      (WidgetTester tester) async {
    var tapCount = 0;
    var longPressCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PressableScale(
              onTap: () => tapCount++,
              onLongPress: () => longPressCount++,
              child: const Text('Long press card'),
            ),
          ),
        ),
      ),
    );

    await tester.longPress(find.text('Long press card'));
    await tester.pumpAndSettle();

    expect(tapCount, 0);
    expect(longPressCount, 1);
  });

  testWidgets('PressableScale respects reduced motion preferences',
      (WidgetTester tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Scaffold(
            body: Center(
              child: PressableScale(
                onTap: () => tapped = true,
                child: const Text('Reduced motion'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Reduced motion'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
