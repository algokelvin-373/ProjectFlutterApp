import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoKelvin Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'AlgoKelvin Flutter 06 UI Rows Columns'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const UIRowsState(),
    );
  }
}

class UIRowsState extends StatelessWidget {
  final String txtBtn1 = 'Button 1';
  final String txtBtn2 = 'Button 2';
  final String txtBtn3 = 'Button 3';
  final String txtBtn4 = 'Button 4';
  final String txtBtn5 = 'Button 5';
  final String txtBtn6 = 'Button 6';

  const UIRowsState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          UIColumnsState(txt1: txtBtn1, txt2: txtBtn2),
          UIColumnsState(txt1: txtBtn3, txt2: txtBtn4),
          UIColumnsState(txt1: txtBtn5, txt2: txtBtn6),
        ],
      ),
    );
  }

}

class UIColumnsState extends StatelessWidget {
  const UIColumnsState({
    Key? key,
    required this.txt1,
    required this.txt2
  }) : super(key: key);

  final String txt1;
  final String txt2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
            child: Text(txt1),
            onPressed: () {
              showToast(context, txt1);
            }
        ),
        Container(width: 10),
        RaisedButton(
            child: Text(txt2),
            onPressed: () {
              showToast(context, txt2);
            }
        ),
      ],
    );
  }

  void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("You press $msg"),
    ));
  }

}
