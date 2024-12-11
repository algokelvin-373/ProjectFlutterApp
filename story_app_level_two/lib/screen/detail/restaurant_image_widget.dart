import 'package:flutter/material.dart';

import '../../data/model/restaurant_detail.dart';

class RestaurantImageWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantImageWidget({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          restaurantDetail.name,
        ),
        background: Hero(
          tag:
              'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
