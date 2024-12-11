import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home/story_list_provider.dart';
import '../../provider/home/restaurant_search_provider.dart';
import '../../utils/global_function.dart';
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
        children: [
          Container(
            margin: verticalSymmetric(10),
            padding: horizontalSymmetric(10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              key: const ValueKey("searchField"),
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search From Here",
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                if (query.trim().isEmpty) {
                  context.read<StoryListProvider>().fetchStoryList();
                } else {
                  context
                      .read<RestaurantSearchProvider>()
                      .fetchRestaurantSearch(query);
                }
              },
            ),
          ),
          StoryListWidget(searchController: _searchController)
        ],
      ),
    );
  }
}
