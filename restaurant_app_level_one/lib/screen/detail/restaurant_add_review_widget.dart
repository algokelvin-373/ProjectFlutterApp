import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/model/review_request.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_review_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_review_result.dart';

class RestaurantAddReviewWidget extends StatefulWidget {
  final String restaurantId;

  const RestaurantAddReviewWidget({super.key, required this.restaurantId});

  @override
  State<RestaurantAddReviewWidget> createState() => _RestaurantAddReviewWidgetState();
}

class _RestaurantAddReviewWidgetState extends State<RestaurantAddReviewWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _widgetAddReview();
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 15,
          ),
        ),
        child: const Text(
          'Add Review',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _widgetAddReview() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text('Add Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: reviewController,
            decoration: const InputDecoration(
              labelText: 'Review',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 15),
          Consumer<RestaurantReviewProvider>(
            builder: (context, provider, child) {
              return provider.resultState is RestaurantReviewLoadingState
                  ? const CircularProgressIndicator()
                  : const SizedBox();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            _postReview();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void _postReview() {
    final name = nameController.text;
    final review = reviewController.text;

    if (name.isNotEmpty && review.isNotEmpty) {
      final reviewRequest = ReviewRequest(
        widget.restaurantId,
        name,
        review,
      );

      try {
        context.read<RestaurantReviewProvider>().fetchRestaurantReview(reviewRequest);
        Future.delayed(const Duration(seconds: 1), () async {
          final resultState = context.read<RestaurantReviewProvider>().resultState;

          if (resultState is RestaurantReviewLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Review added successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            final listCustomerReviewNew = resultState.data;
            context.read<RestaurantReviewProvider>().addReview(listCustomerReviewNew);
            Navigator.of(context).pop();
          } else if (resultState is RestaurantReviewErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to add review: ${resultState.error}"),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pop();
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add review: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields')),
      );
    }
  }
}