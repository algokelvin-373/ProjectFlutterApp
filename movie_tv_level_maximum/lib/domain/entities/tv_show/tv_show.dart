import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  TvShow({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];

  TvShow.simple({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  })  : adult = false,
        backdropPath = '',
        genreIds = [],
        originCountry = [],
        originalLanguage = '',
        originalName = '',
        popularity = 0.0,
        firstAirDate = DateTime(1970, 1, 1),
        voteAverage = 0.0,
        voteCount = 0;

}
