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
      home: const HomePage(title: 'AlgoKelvin Flutter 03 - Button Action'),
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
      body: Center(
        child: ButtonActionState(),
      ),
    );
  }
}

class ButtonActionState extends StatelessWidget {

  final String txtBtn = 'Hello';
  final String titleAlert = 'Hello Alert Dialog';
  final String msgAlert = 'Hello, AlgoKelvin learn Flutter';

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(txtBtn),
      onPressed: () {
        // create action to show dialog
        action(context);
      },
    );
  }

  void action(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(titleAlert),
      content: Text(msgAlert),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

}
