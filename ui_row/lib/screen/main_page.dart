import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: const MainPageState(title: 'Flutter Training - Row'),
    );
  }
}

class MainPageState extends StatefulWidget {
  const MainPageState({super.key, required this.title});

  final String title;

  @override
  State<MainPageState> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageState> {
  Widget _mainPage(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Text 1'),
          Text('Text 2'),
          Text('Text 3'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _mainPage(context),
    );
  }
}
