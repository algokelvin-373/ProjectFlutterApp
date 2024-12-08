import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EvaluateRobot {
  final WidgetTester tester;

  const EvaluateRobot(this.tester);

  final formulaFieldKey = const ValueKey("formulaField");
  final actionButtonKey = const ValueKey("actionButton");
  final resultKey = const ValueKey("result");
  final searchFieldKey = const ValueKey("searchField");
  final loadingIndicatorKey = const ValueKey("loadingIndicator");

  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
  }

  Future<void> inputSearchText(String text) async {
    // Search Data
    final searchField = find.byKey(searchFieldKey);
    expect(searchField, findsOneWidget);

    // Input Text Search
    await tester.enterText(searchField, text);
    await tester.pump();
  }

  Future<void> showLoading() async {
    print('Start Show Loading');
    final loadingIndicator = find.byKey(loadingIndicatorKey);
    expect(loadingIndicator, findsOneWidget);
    await tester.pumpAndSettle();
    print('Finish Show Loading');
  }
}