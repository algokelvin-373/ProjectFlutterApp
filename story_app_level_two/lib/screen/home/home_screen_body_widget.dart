import 'package:flutter/material.dart';

import 'story_list_widget.dart';

class HomeScreenBodyWidget extends StatefulWidget {
  const HomeScreenBodyWidget({super.key});

  @override
  State<HomeScreenBodyWidget> createState() => _HomeScreenBodyWidgetState();
}

class _HomeScreenBodyWidgetState extends State<HomeScreenBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [StoryListWidget()],
      ),
    );
  }
}
