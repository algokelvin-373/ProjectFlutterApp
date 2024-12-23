class TvShowSeason {
  DateTime? airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  TvShowSeason({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvShowSeason.fromJson(Map<String, dynamic> json) => TvShowSeason(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? '',
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
