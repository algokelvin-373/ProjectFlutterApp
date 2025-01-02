import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_episodes.dart';

class TvShowEpisodesNotifier extends ChangeNotifier {
  final GetTvShowEpisodes getTvShowEpisodes;

  late TvShowEpisode _tvShowEpisode;
  TvShowEpisode get tvShowEpisode => _tvShowEpisode;

  RequestState _tvShowEpisodeState = RequestState.Empty;
  RequestState get tvShowEpisodeState => _tvShowEpisodeState;

  String _message = '';
  String get message => _message;

  TvShowEpisodesNotifier({
    required this.getTvShowEpisodes,
  });

  Future<void> fetchTvShowEpisodes(int id, int season) async {
    _tvShowEpisodeState = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowEpisodes.execute(id, season);
    result.fold(
      (failure) {
        _tvShowEpisodeState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowEpisode) {
        _tvShowEpisode = tvShowEpisode;
        _tvShowEpisodeState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
