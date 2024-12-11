import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant_detail.dart';
import '../../provider/detail/restaurant_review_provider.dart';
import 'comment_card.dart';

class RestaurantReviewsWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantReviewsWidget({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantReviewProvider>(
      builder: (context, provider, child) {
        final count = provider.customerReviews.length;
        final listReviewCustomer = count > 0
            ? provider.customerReviews
            : restaurantDetail.customerReviews;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listReviewCustomer.length,
          itemBuilder: (context, index) {
            return CustomerReviewCard(
              customerReview: listReviewCustomer[index],
            );
          },
        );
      },
    );
  }
}
