import 'package:restaurant_app_level_one/data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);
}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;

  RestaurantSearchLoadedState(this.data);
}