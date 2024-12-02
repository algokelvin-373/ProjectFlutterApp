import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_list_result.dart';
import 'package:restaurant_app_level_one/utils/global_function.dart';

import 'food_item_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search From Here",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            // Food List
            Expanded(
              child: Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    RestaurantListLoadedState(data: var restaurantList) => ListView.builder(
                      itemCount: restaurantList.length, // Number of food items
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
                        return FoodItemCard(restaurant: restaurant,);
                      },
                    ),
                    RestaurantListErrorState(error: var message) => Center(
                      child: Text(message),
                    ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}