import 'package:flutter/material.dart';

import 'story_list_widget.dart';

class HomeScreenBodyWidget extends StatelessWidget {
  final Function(String) onTapped;

  const HomeScreenBodyWidget({super.key, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [StoryListWidget(onTapped: onTapped)]),
    );
  }
}
