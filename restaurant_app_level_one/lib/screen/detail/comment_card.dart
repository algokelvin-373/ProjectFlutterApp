import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/model/customer_review.dart';

class CustomerReviewCard extends StatelessWidget {
  final CustomerReview customerReview;

  const CustomerReviewCard({
    super.key,
    required this.customerReview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          Image.asset('images/ic_profile.jpg',
              height: 20,
              fit: BoxFit.cover
          ),
          SizedBox(width: 10), // Space between image and text
          // Username and Comment
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white), // Set default text color
                children: [
                  TextSpan(
                    text: customerReview.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' ${customerReview.review}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}