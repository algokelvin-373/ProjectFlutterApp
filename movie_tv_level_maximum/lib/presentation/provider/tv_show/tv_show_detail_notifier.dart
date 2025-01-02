import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_recommendations.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_watchlist_tv_show_status.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/remove_watchlist_tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/save_watchlist_tv_show.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistTvShowAddSuccessMessage = 'Added to Watchlist TV Show';
  static const watchlistTvShowRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchListTvShowStatus getWatchListTvShowStatus;
  final SaveWatchlistTvShow saveWatchlistTvShow;
  final RemoveWatchlistTvShow removeWatchlistTvShow;

  late TvShowDetail _tvShow;
  TvShowDetail get tvShow => _tvShow;

  RequestState _tvShowState = RequestState.Empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];
  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  bool _isAddedToWatchlistTvShow = false;
  bool get isAddedToWatchlistTvShow => _isAddedToWatchlistTvShow;

  String _message = '';
  String get message => _message;

  String _watchlistTvShowMessage = '';
  String get watchlistTvShowMessage => _watchlistTvShowMessage;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchListTvShowStatus,
    required this.saveWatchlistTvShow,
    required this.removeWatchlistTvShow,
  });

  Future<void> fetchTvShowDetail(int id) async {
    _tvShowState = RequestState.Loading;
    notifyListeners();

    final resultDetail = await getTvShowDetail.execute(id);
    final resultRecommendation = await getTvShowRecommendations.execute(id);
    resultDetail.fold(
      (failure) {
        _tvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.Loading;
        _tvShow = tvShow;
        notifyListeners();
        resultRecommendation.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvShows) {
            _recommendationState = RequestState.Loaded;
            _tvShowRecommendations = tvShows;
          },
        );
        _tvShowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> loadWatchlistTvShowStatus(int id) async {
    final result = await getWatchListTvShowStatus.execute(id);
    _isAddedToWatchlistTvShow = result;
    notifyListeners();
  }

  Future<void> addWatchlistTvShow(TvShowDetail tvShow) async {
    final result = await saveWatchlistTvShow.execute(tvShow);
    await result.fold(
      (failure) async {
        _watchlistTvShowMessage = failure.message;
      },
      (successMessage) async {
        _watchlistTvShowMessage = successMessage;
      },
    );
    await loadWatchlistTvShowStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    final result = await removeWatchlistTvShow.execute(tvShow);
    await result.fold(
      (failure) async {
        _watchlistTvShowMessage = failure.message;
      },
      (successMessage) async {
        _watchlistTvShowMessage = successMessage;
      },
    );
    await loadWatchlistTvShowStatus(tvShow.id);
  }
}
