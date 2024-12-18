import '../../../domain/entities/genre.dart';

class TvShowDetailResponse {
  bool adult;
  String backdropPath;
  //List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  //List<Genre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  //TEpisodeToAir lastEpisodeToAir;
  String name;
  //TEpisodeToAir nextEpisodeToAir;
  //List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  //List<Network> productionCompanies;
  //List<ProductionCountry> productionCountries;
  //List<Season> seasons;
  //List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  TvShowDetailResponse({
    required this.adult,
    required this.backdropPath,
    //required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    //required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    //required this.lastEpisodeToAir,
    required this.name,
    //required this.nextEpisodeToAir,
    //required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    //required this.productionCompanies,
    //required this.productionCountries,
    //required this.seasons,
    //required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowDetailResponse.fromJson(Map<String, dynamic> json) => TvShowDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    //createdBy: List<CreatedBy>.from(json["created_by"].map((x) => CreatedBy.fromJson(x))),
    episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
    firstAirDate: DateTime.parse(json["first_air_date"]),
    //genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    lastAirDate: DateTime.parse(json["last_air_date"]),
    //lastEpisodeToAir: TEpisodeToAir.fromJson(json["last_episode_to_air"]),
    name: json["name"],
    //nextEpisodeToAir: TEpisodeToAir.fromJson(json["next_episode_to_air"]),
    //networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    //productionCompanies: List<Network>.from(json["production_companies"].map((x) => Network.fromJson(x))),
    //productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
    //seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
    //spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    //"created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
    "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
    "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    //"genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "last_air_date": "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
    //"last_episode_to_air": lastEpisodeToAir.toJson(),
    "name": name,
    //"next_episode_to_air": nextEpisodeToAir.toJson(),
    //"networks": List<dynamic>.from(networks.map((x) => x.toJson())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    //"production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    //"production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
    //"seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    //"spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}