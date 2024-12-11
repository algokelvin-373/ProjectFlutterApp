import 'customer_review.dart';

class RestaurantReviewResponse {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  RestaurantReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantReviewResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
