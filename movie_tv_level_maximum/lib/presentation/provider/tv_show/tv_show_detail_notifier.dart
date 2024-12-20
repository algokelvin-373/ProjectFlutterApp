import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_recommendations.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;

  late TvShowDetail _tvShow;
  TvShowDetail get tvShow => _tvShow;

  RequestState _tvShowState = RequestState.Empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];
  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
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
}
