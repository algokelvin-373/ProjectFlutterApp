import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Train',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: const HomePageState(
        title: 'Flutter Train',
      ),
    );
  }
}

class HomePageState extends StatefulWidget {
  const HomePageState({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePageState> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  Widget _mainPageWidget(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Flutter Developer with AlgoKelvin'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme,
        title: Text(widget.title),
      ),
      body: _mainPageWidget(context),
    );
  }
}
