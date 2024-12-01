import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_detaill_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_detail_result.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(data: var restaurant) =>
                DetailRestaurantBodyWidget(restaurantDetail: restaurant),
            RestaurantDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

class DetailRestaurantBodyWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const DetailRestaurantBodyWidget({
    super.key,
    required this.restaurantDetail,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar with the image
        SliverAppBar(
          expandedHeight: 350,
          pinned: true,
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // SliverList for the details section
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Name and Counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurantDetail.name,
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  restaurantDetail.address,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 15),
                // Rating, Time, Calories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconText(icon: Icons.star, label: restaurantDetail.rating.toString()),
                    IconText(icon: Icons.location_city, label: restaurantDetail.city),
                  ],
                ),
                SizedBox(height: 20),
                // Nutritional Info
                Text(
                  restaurantDetail.description,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 15),
                Text(
                  'Customize >',
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 16),
                ),
                SizedBox(height: 25),
                // Total and Add to Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '\$30.00',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    child: Text(
                      'Add to cart',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable IconText Widget
class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}