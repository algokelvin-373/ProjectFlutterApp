import 'package:calculator_unit_testing/providers/math_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/action_button_widget.dart';
import 'widgets/formula_field_widget.dart';
import 'widgets/result_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tecFormula = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const ValueKey("appBar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormulaField(
              key: const ValueKey("formulaField"),
              tecFormula: tecFormula,
            ),
            const SizedBox.square(dimension: 8),
            ActionButton(
              key: const ValueKey("actionButton"),
              onPressed: () => execute(),
            ),
            const SizedBox.square(dimension: 8),
            const Expanded(
              child: Center(
                child: ResultText(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void execute() {
    final formula = tecFormula.text;
    final mathProvider = context.read<MathProvider>();

    if (formula.isNotEmpty) {
      mathProvider.evaluate(formula);
    }
  }
}
