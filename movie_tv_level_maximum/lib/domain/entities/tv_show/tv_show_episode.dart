import '../../../data/models/tv_show/tv_show_episode.dart';

class TvShowEpisode {
  String id;
  DateTime airDate;
  List<TvShowEpisodeModel> episodes;
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

  factory TvShowEpisode.fromJson(Map<String, dynamic> json) => TvShowEpisode(
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": tvShowEpisodeResponseId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}
