import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_top_rated.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv_show/tv_show.dart';
import '../../../domain/use_cases/tv_show/get_tv_show_popular.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  final GetTopRatedTvShow getTopRatedTvShow;

  var _tvShows = <TvShow>[];
  List<TvShow> get tvShows => _tvShows;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  TopRatedTvShowsNotifier({
    required this.getTopRatedTvShow,
  });

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();
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