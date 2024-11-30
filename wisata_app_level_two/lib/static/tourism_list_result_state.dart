import 'package:wisata_app_level_two/data/model/tourism.dart';

sealed class TourismListResultState {}

class TourismListNoneState extends TourismListResultState {}

class TourismListLoadingState extends TourismListResultState {}

class TourismListErrorState extends TourismListResultState {
  final String error;

  TourismListErrorState(this.error);
}

class TourismListLoadedState extends TourismListResultState {
  final List<Tourism> data;

  TourismListLoadedState(this.data);
}