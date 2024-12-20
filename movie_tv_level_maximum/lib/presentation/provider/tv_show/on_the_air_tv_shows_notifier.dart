import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_on_the_air.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv_show/tv_show.dart';

class OnTheAirTvShowsNotifier extends ChangeNotifier {
  final GetOnTheAirTvShow getOnTheAirTvShow;

  var _tvShows = <TvShow>[];
  List<TvShow> get tvShows => _tvShows;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  OnTheAirTvShowsNotifier({
    required this.getOnTheAirTvShow,
  });

  Future<void> fetchOnTheAirTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvShow.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _state = RequestState.Loaded;
      _tvShows = tvShowsData;
      notifyListeners();
    });
  }
}