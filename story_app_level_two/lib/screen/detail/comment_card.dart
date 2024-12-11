import 'package:flutter/material.dart';

import '../../data/model/customer_review.dart';
import '../../utils/global_function.dart';

class CustomerReviewCard extends StatelessWidget {
  final CustomerReview customerReview;

  const CustomerReviewCard({
    super.key,
    required this.customerReview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              'images/ic_profile.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          spaceHorizontal(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerReview.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  customerReview.date,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  customerReview.review,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}