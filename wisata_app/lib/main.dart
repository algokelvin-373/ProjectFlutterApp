import 'package:flutter/material.dart';
import 'package:wisata_app/detail_screen.dart';
import 'package:wisata_app/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata App',
      theme: ThemeData(),
      home: MainScreen(),
    );
  }
}
