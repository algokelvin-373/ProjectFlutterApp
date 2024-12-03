import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/screen/home/home_screen_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant App"),
        elevation: 0,
      ),
      body: const HomeScreenBodyWidget(),
    );
  }
}