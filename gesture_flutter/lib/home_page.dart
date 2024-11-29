import 'package:flutter/material.dart';

import 'my_bookmark_icon_widget.dart';
import 'my_container_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyContainerWidget(),
              MyBookmarkIconWidget(),
            ],
          ),
        ),
      ),
    );
  }
}