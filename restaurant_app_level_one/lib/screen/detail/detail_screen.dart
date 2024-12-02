import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_detaill_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_detail_result.dart';

import 'detail_restaurant_body_widget.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  void _showErrorDialog(String message, String id) {
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
                  context.read<RestaurantDetailProvider>().fetchRestaurantDetail(id); // Refresh data
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
      backgroundColor: Colors.black,
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          if (value.resultState is RestaurantDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.resultState is RestaurantDetailLoadedState) {
            final restaurantDetail = (value.resultState as RestaurantDetailLoadedState).data;
            return DetailRestaurantBodyWidget(restaurantDetail: restaurantDetail);
          } else if (value.resultState is RestaurantDetailErrorState)  {
            final message = (value.resultState as RestaurantDetailErrorState).error;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorDialog(message, widget.restaurantId);
            });
            return const Center(child: Text("Error loading data."));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}