import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/static/restaurant_detail_result.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices,);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}