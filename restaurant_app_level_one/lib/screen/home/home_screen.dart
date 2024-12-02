import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_list_result.dart';
import 'package:restaurant_app_level_one/static/restaurant_search_result.dart';
import 'package:restaurant_app_level_one/utils/global_function.dart';

import 'food_item_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late List<Restaurant> _getListRestaurant = [];

  final TextEditingController _searchController = TextEditingController();
  //List<Restaurant> _filteredRestaurant = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
    //_searchController.addListener(_filterRestaurant);
  }

  /*void _filterRestaurant() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRestaurant = _getListRestaurant.where((restaurant) {
        return restaurant.name.toLowerCase().contains(query);
      }).toList();
    });
  }*/

  void _showErrorDialogListRestaurant(String message) {
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
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<RestaurantListProvider>().fetchRestaurantList(); // Refresh data
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialogSearchRestaurant(String message, String search) {
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
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<RestaurantSearchProvider>().fetchRestaurantSearch(search);
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "Restaurant App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              margin: verticalSymmetric(10),
              padding: horizontalSymmetric(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search From Here",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  if (query.trim().isEmpty) {
                    context.read<RestaurantListProvider>().fetchRestaurantList();
                  } else {
                    context.read<RestaurantSearchProvider>().fetchRestaurantSearch(query);
                  }
                },
              ),
            ),
            // Food List
            Expanded(
              child: Consumer2<RestaurantListProvider, RestaurantSearchProvider>(
                builder: (context, list, search, child) {
                  final searchQuery = _searchController.text.trim();
                  if (searchQuery.isEmpty) { // Get List Restaurant - RestaurantListProvider
                    if (list.resultState is RestaurantListLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
                        _showErrorDialogListRestaurant(message);
                      });
                      return const Center(child: Text("Error loading data."));
                    } else {
                      return const SizedBox();
                    }
                  } else { // Get List Restaurant by Search Data
                    if (search.resultState is RestaurantSearchLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
                        _showErrorDialogSearchRestaurant(message, searchQuery);
                      });
                      return const Center(child: Text("Error loading data."));
                    } else {
                      return const SizedBox();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}