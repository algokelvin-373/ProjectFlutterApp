import 'package:calculator_unit_testing/providers/math_provider.dart';
import 'package:calculator_unit_testing/screens/home/home_screen.dart';
import 'package:calculator_unit_testing/screens/home/widgets/action_button_widget.dart';
import 'package:calculator_unit_testing/screens/home/widgets/formula_field_widget.dart';
import 'package:calculator_unit_testing/screens/home/widgets/result_text_widget.dart';
import 'package:calculator_unit_testing/static/evaluate_formula_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockMathProvider extends Mock implements MathProvider {}

void main() {
  late MockMathProvider mathProvider;
  late Widget widget;

  setUp(() {
    mathProvider = MockMathProvider();
    widget = MaterialApp(
      home: ChangeNotifierProvider<MathProvider>(
        create: (context) => mathProvider,
        child: const HomeScreen(),
      ),
    );
  });

  group('home screen', () {
    testWidgets(
        "have every component, like AppBar, FormulaField, ActionButton, and ResultText when first launch",
            (tester) async {
          await tester.pumpWidget(widget);

          // memeriksa setiap tipe widget di layar
          final appBarFinder = find.byType(AppBar);
          final formulaFieldFinder = find.byType(FormulaField);
          final actionButtonFinder = find.byType(ActionButton);
          final resultTextFinder = find.byType(ResultText);

          expect(appBarFinder, findsOneWidget);
          expect(formulaFieldFinder, findsOneWidget);
          expect(actionButtonFinder, findsOneWidget);
          expect(resultTextFinder, findsOneWidget);

          // memeriksa teks dalam AppBar
          final textInAppBarFinder = find.descendant(
            of: appBarFinder,
            matching: find.byType(Text),
          );
          final textInAppBar = tester.widget<Text>(textInAppBarFinder);
          expect(textInAppBar.data, "Calculator App");

          // memeriksa teks kosong dalam FormulaField
          final editableTextFinder = find.descendant(
            of: formulaFieldFinder,
            matching: find.byType(EditableText),
          );
          final EditableTextState editableText = tester.state(editableTextFinder);
          expect(editableText.widget.controller.text, isEmpty);

          // memeriksa pengujian dalam ActionButton
          final textInActionButtonFinder = find.descendant(
            of: actionButtonFinder,
            matching: find.byType(Text),
          );
          final textInActionButton = tester.widget<Text>(textInActionButtonFinder);
          expect(textInActionButton.data, "Execute");

          // memeriksa widget kosong(SizedBox) dalam ResultText
          final sizedBoxWithinResultTextFinder = find.descendant(
            of: resultTextFinder,
            matching: find.byType(SizedBox),
          );
          expect(sizedBoxWithinResultTextFinder, findsOneWidget);
        });

    testWidgets("write a right formula and execute the button", (tester) async {
      const rightFormula = "3*25";
      const rightEvaluate = "75.0";
      when(() => mathProvider.state).thenReturn(SuccessEvaluate(rightEvaluate));

      await tester.pumpWidget(widget);

      // mengetik formula
      final formulaFieldFinder = find.byType(FormulaField);
      final editableTextFinder = find.descendant(
        of: formulaFieldFinder,
        matching: find.byType(EditableText),
      );
      await tester.enterText(editableTextFinder, rightFormula);
      await tester.pump();

      // menekan tombol
      final actionButtonFinder = find.byType(ActionButton);
      await tester.tap(actionButtonFinder);
      await tester.pump();

      // memeriksa output
      final resultTextFinder = find.byType(ResultText);
      final textWithinResultTextFinder = find.descendant(
        of: resultTextFinder,
        matching: find.byType(Text),
      );
      final text = tester.widget<Text>(textWithinResultTextFinder);
      expect(text.data, rightEvaluate);
    });

    testWidgets("write a wrong formula and execute the button", (tester) async {
      const wrongFormula = "Math";
      const wrongEvaluate = "Cannot evaluate that formula.";
      when(() => mathProvider.state).thenReturn(FailedEvaluate(wrongEvaluate));

      await tester.pumpWidget(widget);

      // mengetik formula
      final formulaFieldFinder = find.byType(FormulaField);
      final editableTextFinder = find.descendant(
        of: formulaFieldFinder,
        matching: find.byType(EditableText),
      );
      await tester.enterText(editableTextFinder, wrongFormula);
      await tester.pump();

      // menekan tombol
      final actionButtonFinder = find.byType(ActionButton);
      await tester.tap(actionButtonFinder);
      await tester.pump();

      // memeriksa output
      final resultTextFinder = find.byType(ResultText);
      final textWithinResultTextFinder = find.descendant(
        of: resultTextFinder,
        matching: find.byType(Text),
      );
      final text = tester.widget<Text>(textWithinResultTextFinder);
      expect(text.data, wrongEvaluate);
    });
  });
}