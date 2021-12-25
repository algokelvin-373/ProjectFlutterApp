import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.network('https://raw.githack.com/algokelvin-373/algokelvin-373/master/my_resources/Logo%20AlgoKelvin%20v3%20(2).png',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              'Hello World Flutter Programming',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            const Text(
              'AlgoKelvin learn Flutter Programming',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
