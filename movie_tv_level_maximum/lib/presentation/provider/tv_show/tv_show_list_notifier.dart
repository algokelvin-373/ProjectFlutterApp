import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_airing_today.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_on_the_air.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_popular.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_top_rated.dart';

class TvShowListNotifier extends ChangeNotifier {
  final GetAiringTodayTvShow getAiringTodayTvShow;
  final GetOnTheAirTvShow getOnTheAirTvShow;
  final GetPopularTvShow getPopularTvShow;
  final GetTopRatedTvShow getTopRatedTvShow;

  var _airingTodayTvShows = <TvShow>[];
  List<TvShow> get airingTodayTvShows => _airingTodayTvShows;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _onTheAirTvShows = <TvShow>[];
  List<TvShow> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getAiringTodayTvShow,
    required this.getOnTheAirTvShow,
    required this.getPopularTvShow,
    required this.getTopRatedTvShow,
  });

  Future<void> fetchAiringTodayTvShows() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvShow.execute();
    result.fold((failure) {
      _airingTodayState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _airingTodayState = RequestState.Loaded;
      _airingTodayTvShows = tvShowsData;
      notifyListeners();
    });
  }

  Future<void> fetchOnTheAirTvShows() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvShow.execute();
    result.fold((failure) {
      _onTheAirState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _onTheAirState = RequestState.Loaded;
      _onTheAirTvShows = tvShowsData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvShows() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShow.execute();
    result.fold((failure) {
      _popularState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _popularState = RequestState.Loaded;
      _popularTvShows = tvShowsData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();
    result.fold((failure) {
      _topRatedState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowsData) {
      _topRatedState = RequestState.Loaded;
      _topRatedTvShows = tvShowsData;
      notifyListeners();
    });
  }
}
