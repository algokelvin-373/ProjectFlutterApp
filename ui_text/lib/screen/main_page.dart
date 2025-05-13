import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String message1 = 'Hello World on Flutter Developer';
  static const String message2 = 'Text Size 14';
  static const String message3 = 'Text Size 16, Color Red';
  static const String message4 = 'Text Size 18, Color Blue, Bold';

  Widget _mainPage(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message1), // Without TextStyle
          Text(
            message2,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            message3,
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          Text(
            message4,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
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
