import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movie/movie.dart';
import '../../../domain/use_cases/movie/get_watchlist_movies.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
