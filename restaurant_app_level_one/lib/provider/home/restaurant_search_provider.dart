import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/static/restaurant_search_result.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  Future<void> fetchRestaurantSearch(String search) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantBySearch(search);

      if (result.error) {
        _resultState = RestaurantSearchErrorState("Searching is Failed");
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}