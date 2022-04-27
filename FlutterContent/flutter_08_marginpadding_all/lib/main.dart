import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoKelvin Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AlgoKelvin Flutter 08 Margin Padding All'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.grey,
            child: const BtnWithoutMarginPadding(),
          ),
          Container(
            color: Colors.grey,
            child: const BtnWithMarginPadding(),
          ),
        ],
      )
    );
  }
}

class BtnWithoutMarginPadding extends StatelessWidget {
  const BtnWithoutMarginPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.blue,
          child: RaisedButton(
            child: Text('Button 1'),
            onPressed: () {},
          ),
        ),
        Container(
          color: Colors.redAccent,
          child: RaisedButton(
            child: Text('Button 2'),
            onPressed: () {},
          ),
        ),
        Container(
          color: Colors.green,
          child: RaisedButton(
            child: Text('Button 3'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class BtnWithMarginPadding extends StatelessWidget {
  const BtnWithMarginPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.blue,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: RaisedButton(
            child: Text('Button 1'),
            onPressed: () {},
          ),
        ),
        Container(
          color: Colors.redAccent,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: RaisedButton(
            child: Text('Button 2'),
            onPressed: () {},
          ),
        ),
        Container(
          color: Colors.green,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: RaisedButton(
            child: Text('Button 3'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
