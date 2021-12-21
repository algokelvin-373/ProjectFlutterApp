import 'package:flutter/material.dart';
import 'package:hello_flutter_two/AppStatefulWidget/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AlgoKelvin: Flutter Beginner'),
    );
  }
}