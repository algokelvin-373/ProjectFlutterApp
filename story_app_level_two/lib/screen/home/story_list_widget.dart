import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home/story_list_provider.dart';
import '../../provider/home/restaurant_search_provider.dart';
import '../../static/restaurant_list_result.dart';
import '../../static/restaurant_search_result.dart';
import 'story_item_card_widget.dart';

class StoryListWidget extends StatefulWidget {
  final TextEditingController searchController;

  const StoryListWidget({
    super.key,
    required this.searchController,
  });

  @override
  State<StoryListWidget> createState() => _StoryListWidgetState();
}

class _StoryListWidgetState extends State<StoryListWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StoryListProvider>().fetchStoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer2<StoryListProvider, RestaurantSearchProvider>(
        builder: (context, list, search, child) {
          final searchQuery = widget.searchController.text.trim();
          if (searchQuery.isEmpty) {
            // Get List Restaurant - RestaurantListProvider
            return _widgetListRestaurant(list);
          } else {
            // Get List Restaurant by Search Data
            return _widgetSearchRestaurant(search, searchQuery);
          }
        },
      ),
    );
  }

  Widget _widgetListRestaurant(StoryListProvider list) {
    if (list.resultState is StoryListLoadingState) {
      return const Center(
        child: CircularProgressIndicator(key: ValueKey("loadingIndicatorAll")),
      );
    } else if (list.resultState is StoryListLoadedState) {
      final restaurantList =
          (list.resultState as StoryListLoadedState).data;
      return ListView.builder(
        key: const ValueKey("listRestaurant"),
        itemCount: restaurantList.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantList[index];
          return StoryItemCardWidget(restaurant: restaurant);
        },
      );
    } else if (list.resultState is StoryListErrorState) {
      final message = (list.resultState as StoryListErrorState).error;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(message, () {
          context
              .read<StoryListProvider>()
              .fetchStoryList(); // Refresh data
        });
      });
      return const Center(child: Text("Error loading data."));
    } else {
      return const SizedBox();
    }
  }

  Widget _widgetSearchRestaurant(
      RestaurantSearchProvider search, String searchQuery) {
    if (search.resultState is RestaurantSearchLoadingState) {
      return const Center(
        child: CircularProgressIndicator(key: ValueKey("loadingIndicator")),
      );
    } else if (search.resultState is RestaurantSearchLoadedState) {
      final restaurantListBySearch =
          (search.resultState as RestaurantSearchLoadedState).data;
      return ListView.builder(
        key: const ValueKey("listSearchRestaurant"),
        itemCount: restaurantListBySearch.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantListBySearch[index];
          return StoryItemCardWidget(restaurant: restaurant);
        },
      );
    } else if (search.resultState is RestaurantSearchErrorState) {
      final message = (search.resultState as RestaurantSearchErrorState).error;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(message, () {
          context
              .read<RestaurantSearchProvider>()
              .fetchRestaurantSearch(searchQuery); // Refresh search data
        });
      });
      return const Center(child: Text("Error loading data."));
    } else {
      return const SizedBox();
    }
  }

  void _showErrorDialog(String message, VoidCallback onRefresh) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Error Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRefresh(); // Call refresh action
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }
}
