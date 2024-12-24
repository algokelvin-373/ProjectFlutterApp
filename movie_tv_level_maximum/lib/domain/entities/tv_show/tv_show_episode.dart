import 'package:equatable/equatable.dart';

import 'episode_tv_show.dart';

class TvShowEpisode extends Equatable {
  final String id;
  final DateTime airDate;
  final List<EpisodeTvShow> episodes;
  final String name;
  final String overview;
  final int tvShowEpisodeResponseId;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;

  const TvShowEpisode({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.tvShowEpisodeResponseId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        tvShowEpisodeResponseId,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
