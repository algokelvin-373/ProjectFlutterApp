import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_list_result.dart';
import 'package:restaurant_app_level_one/static/restaurant_search_result.dart';

import 'food_item_card.dart';

class FoodListWidget extends StatefulWidget {
  final TextEditingController searchController;

  const FoodListWidget({
    super.key,
    required this.searchController,
  });

  @override
  State<FoodListWidget> createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer2<RestaurantListProvider, RestaurantSearchProvider>(
        builder: (context, list, search, child) {
          final searchQuery = widget.searchController.text.trim();
          if (searchQuery.isEmpty) { // Get List Restaurant - RestaurantListProvider
            return _widgetListRestaurant(list);
          } else { // Get List Restaurant by Search Data
            return _widgetSearchRestaurant(search, searchQuery);
          }
        },
      ),
    );
  }

  Widget _widgetListRestaurant(RestaurantListProvider list) {
    if (list.resultState is RestaurantListLoadingState) {
      return const Center(
        child: CircularProgressIndicator(key: ValueKey("loadingIndicator")),
      );
    } else if (list.resultState is RestaurantListLoadedState) {
      final restaurantList = (list.resultState as RestaurantListLoadedState).data;
      return ListView.builder(
        itemCount: restaurantList.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantList[index];
          return FoodItemCard(restaurant: restaurant);
        },
      );
    } else if (list.resultState is RestaurantListErrorState) {
      final message = (list.resultState as RestaurantListErrorState).error;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(message, () {
          context.read<RestaurantListProvider>().fetchRestaurantList(); // Refresh data
        });
      });
      return const Center(child: Text("Error loading data."));
    } else {
      return const SizedBox();
    }
  }

  Widget _widgetSearchRestaurant(RestaurantSearchProvider search, String searchQuery) {
    if (search.resultState is RestaurantSearchLoadingState) {
      return const Center(
        child: CircularProgressIndicator(key: ValueKey("loadingIndicator")),
      );
    } else if (search.resultState is RestaurantSearchLoadedState) {
      final restaurantListBySearch = (search.resultState as RestaurantSearchLoadedState).data;
      return ListView.builder(
        itemCount: restaurantListBySearch.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantListBySearch[index];
          return FoodItemCard(restaurant: restaurant);
        },
      );
    } else if (search.resultState is RestaurantSearchErrorState) {
      final message = (search.resultState as RestaurantSearchErrorState).error;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(message, () {
          context.read<RestaurantSearchProvider>().fetchRestaurantSearch(searchQuery); // Refresh search data
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