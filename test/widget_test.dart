import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/widgets/app_text_field.dart';

void main() {
  testWidgets('navigation, theme, masked passwords and keyboard layout', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(AppTextField), findsNWidgets(2));
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isTrue,
    );
    await tester.enterText(find.byType(TextField).first, 'student@example.com');
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign up'));
    expect(tester.takeException(), isNull);
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.byType(AppTextField), findsNWidgets(4));
    expect(find.byType(BackButton), findsOneWidget);
    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields[2].obscureText && fields[3].obscureText, isTrue);
    await tester.tap(find.byTooltip('Dark mode'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold).last)).brightness,
      Brightness.dark,
    );
    tester.view.physicalSize = const Size(320, 640);
    tester.view.viewInsets = const FakeViewPadding(bottom: 280);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'examplePassword');
    await tester.ensureVisible(find.text('Create account'));
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.byType(AppTextField), findsNWidgets(2));
    expect(find.text('student@example.com'), findsOneWidget);
    tester.view.resetViewInsets();
    tester.view.physicalSize = const Size(390, 844);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign up'));
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(AppTextField), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });
}

