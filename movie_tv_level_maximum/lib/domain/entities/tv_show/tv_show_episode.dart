import 'package:movie_tv_level_maximum/domain/entities/tv_show/episode_tv_show.dart';

class TvShowEpisode {
  String id;
  DateTime airDate;
  List<EpisodeTvShow> episodes;
  String name;
  String overview;
  int tvShowEpisodeResponseId;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  TvShowEpisode({
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "airDate": DateTime.parse("${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}"),
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "tvShowEpisodeResponseId": tvShowEpisodeResponseId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}
