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
      home: const HomePage(title: 'AlgoKelvin Flutter 05 UI Columns'),
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
      body: UIColumnsState(),
    );
  }
}

class UIColumnsState extends StatelessWidget {
  final String txtBtn1 = 'Button 1';
  final String txtBtn2 = 'Button 2';
  final String txtBtn3 = 'Button 3';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: Text(txtBtn1),
              onPressed: () {
                showToast(context, txtBtn1);
              }
          ),
          Container(width: 10),
          RaisedButton(
              child: Text(txtBtn2),
              onPressed: () {
                showToast(context, txtBtn2);
              }
          ),
          Container(width: 10),
          RaisedButton(
              child: Text(txtBtn3),
              onPressed: () {
                showToast(context, txtBtn3);
              }
          ),
        ],
      ),
    );
  }

  void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("You press $msg"),
    ));
  }
}
