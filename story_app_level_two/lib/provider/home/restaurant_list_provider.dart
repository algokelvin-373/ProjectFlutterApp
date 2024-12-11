import 'package:flutter/material.dart';

import '../../data/api/api_services.dart';
import '../../static/restaurant_list_result.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  void setResultState(RestaurantListResultState state) {
    _resultState = state;
    notifyListeners();
  }

  Future<void> fetchRestaurantList() async {
    // Set to loading state before making API call
    _resultState = RestaurantListLoadingState();
    notifyListeners(); // Notify listeners about the state change

    try {
      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}
