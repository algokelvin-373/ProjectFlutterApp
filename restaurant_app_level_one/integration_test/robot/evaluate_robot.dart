import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EvaluateRobot {
  final WidgetTester tester;

  const EvaluateRobot(this.tester);

  final formulaFieldKey = const ValueKey("formulaField");
  final actionButtonKey = const ValueKey("actionButton");
  final resultKey = const ValueKey("result");

  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
  }
}