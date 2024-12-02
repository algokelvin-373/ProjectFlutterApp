import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/data/model/review_request.dart';
import 'package:restaurant_app_level_one/static/restaurant_review_result.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantReviewProvider(this._apiServices,);

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
}