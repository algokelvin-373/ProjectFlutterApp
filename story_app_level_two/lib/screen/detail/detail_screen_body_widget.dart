import 'package:flutter/material.dart';

import '../../data/model/restaurant_detail.dart';
import 'restaurant_data_widget.dart';
import 'restaurant_image_widget.dart';

class DetailScreenBodyWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const DetailScreenBodyWidget({
    super.key,
    required this.restaurantDetail,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        RestaurantImageWidget(restaurantDetail: restaurantDetail),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              //color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: RestaurantDataWidget(restaurantDetail: restaurantDetail),
          ),
        ),
      ],
    );
  }
}
