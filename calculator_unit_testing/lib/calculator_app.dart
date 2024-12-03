import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/math_provider.dart';
import 'screens/home/home_screen.dart';
import 'services/math_expression.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => MathExpression(),
        ),
        ChangeNotifierProvider(
          create: (context) => MathProvider(
            context.read<MathExpression>(),
          ),
        ),
      ],
      child: const CalculatorAppView(),
    );
  }
}

class CalculatorAppView extends StatelessWidget {
  const CalculatorAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
