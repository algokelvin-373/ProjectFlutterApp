import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_watchlist_tv_shows.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  final GetWatchlistTvShows getWatchlistTvShows;

  var _watchlistTvShows = <TvShow>[];
  get watchlistTvShows => _watchlistTvShows;

  RequestState _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvShowNotifier({
    required this.getWatchlistTvShows,
  });

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
