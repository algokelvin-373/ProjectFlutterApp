import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_episode.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';

class TvShowEpisodeResponse {
  String id;
  DateTime airDate;
  List<TvShowEpisodeModel> episodes;
  String name;
  String overview;
  int tvShowEpisodeResponseId;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  TvShowEpisodeResponse({
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

  TvShowEpisode toEntity() {
    return TvShowEpisode(
        id: id,
        airDate: airDate,
        episodes: episodes,
        name: name,
        overview: overview,
        tvShowEpisodeResponseId: tvShowEpisodeResponseId,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
        voteAverage: voteAverage);
  }

  factory TvShowEpisodeResponse.fromJson(Map<String, dynamic> json) =>
      TvShowEpisodeResponse(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<TvShowEpisodeModel>.from(
            json["episodes"].map((x) => TvShowEpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        tvShowEpisodeResponseId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
