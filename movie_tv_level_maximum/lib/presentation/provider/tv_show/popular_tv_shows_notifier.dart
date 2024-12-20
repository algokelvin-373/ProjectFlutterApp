import 'package:flutter/material.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv_show/tv_show.dart';
import '../../../domain/use_cases/tv_show/get_tv_show_popular.dart';

class PopularTvShowsNotifier extends ChangeNotifier {
  final GetPopularTvShow getPopularTvShow;

  var _tvShows = <TvShow>[];
  List<TvShow> get tvShows => _tvShows;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  PopularTvShowsNotifier({
    required this.getPopularTvShow,
  });

  Future<void> fetchPopularTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShow.execute();
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