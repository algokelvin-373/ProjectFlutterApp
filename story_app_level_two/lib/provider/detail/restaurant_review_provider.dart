import 'package:flutter/material.dart';

import '../../data/api/api_services.dart';
import '../../data/model/customer_review.dart';
import '../../data/model/review_request.dart';
import '../../static/restaurant_review_result.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  final List<CustomerReview> _customerReviews = [];

  List<CustomerReview> get customerReviews => _customerReviews;

  RestaurantReviewProvider(
    this._apiServices,
  );

  RestaurantReviewResultState _resultState = RestaurantReviewNoneState();

  RestaurantReviewResultState get resultState => _resultState;

  Future<void> fetchRestaurantReview(ReviewRequest request) async {
    try {
      _resultState = RestaurantReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.addRestaurantReview(request);

      if (result.error) {
        _resultState = RestaurantReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantReviewErrorState(e.toString());
      notifyListeners();
    }
  }

  void addReview(List<CustomerReview> review) {
    _customerReviews.addAll(review);
    notifyListeners();
  }
}
