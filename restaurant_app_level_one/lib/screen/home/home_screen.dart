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

  void _showErrorDialog(String message) {
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
                  if (value.resultState is RestaurantListLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (value.resultState is RestaurantListLoadedState) {
                    final restaurantList = (value.resultState as RestaurantListLoadedState).data;
                    return ListView.builder(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
                        return FoodItemCard(restaurant: restaurant);
                      },
                    );
                  } else if (value.resultState is RestaurantListErrorState) {
                    final message = (value.resultState as RestaurantListErrorState).error;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showErrorDialog(message);
                    });
                    return const Center(child: Text("Error loading data."));
                  } else {
                    return const SizedBox();
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