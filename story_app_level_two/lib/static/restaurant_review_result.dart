import '../data/model/customer_review.dart';

sealed class RestaurantReviewResultState {}

class RestaurantReviewNoneState extends RestaurantReviewResultState {}

class RestaurantReviewLoadingState extends RestaurantReviewResultState {}

class RestaurantReviewErrorState extends RestaurantReviewResultState {
  final String error;

  RestaurantReviewErrorState(this.error);
}

class RestaurantReviewLoadedState extends RestaurantReviewResultState {
  final List<CustomerReview> data;

  RestaurantReviewLoadedState(this.data);
}
