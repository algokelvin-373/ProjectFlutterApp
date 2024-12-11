import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/restaurant_detail_provider.dart';
import '../../static/restaurant_detail_result.dart';
import 'detail_screen_body_widget.dart';

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
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<RestaurantDetailProvider>()
                      .fetchRestaurantDetail(id); // Refresh data
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
      body: Consumer<RestaurantDetailProvider>(
        builder: (_, value, __) {
          if (value.resultState is RestaurantDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.resultState is RestaurantDetailLoadedState) {
            final restaurantDetail = (value.resultState as RestaurantDetailLoadedState).data;
            return DetailScreenBodyWidget(restaurantDetail: restaurantDetail);
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