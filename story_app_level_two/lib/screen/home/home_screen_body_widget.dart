import 'package:flutter/material.dart';

import 'story_list_widget.dart';

class HomeScreenBodyWidget extends StatefulWidget {
  const HomeScreenBodyWidget({super.key});

  @override
  State<HomeScreenBodyWidget> createState() => _HomeScreenBodyWidgetState();
}

class _HomeScreenBodyWidgetState extends State<HomeScreenBodyWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [StoryListWidget(searchController: _searchController)],
      ),
    );
  }
}
