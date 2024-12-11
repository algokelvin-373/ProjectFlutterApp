import 'package:flutter/foundation.dart';

import '../../data/local/db_service.dart';
import '../../data/model/story/story.dart';

/*class DbProvider extends ChangeNotifier {
  final DbService _service;

  DbProvider(this._service);

  String _message = "";

  String get message => _message;

  List<Restaurant>? _restaurantList;

  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;

  Restaurant? get restaurant => _restaurant;

  Future<void> saveRestaurant(Restaurant value) async {
    try {
      final result = await _service.insertRestaurantFavorite(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> loadAllRestaurant() async {
    try {
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      _message = "All of your data is loaded";
      if (kDebugMode) {
        print("Masuk loadAll : $_message");
      }
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeItem(id);
      await loadAllRestaurant();
      _message = "Your favorite is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your favorite";
      notifyListeners();
    }
  }

*//*bool checkItemBookmark(int id) {
    final isSameTourism = _restaurant!.id == id;
    return isSameTourism;
  }*//*
}*/
