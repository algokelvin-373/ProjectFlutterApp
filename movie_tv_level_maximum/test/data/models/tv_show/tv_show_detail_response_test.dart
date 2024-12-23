import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_detail_response.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/genre_tv_show_model.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';

void main() {
  final tTvShowDetailResponse = TvShowDetailResponse(
    adult: false,
    backdropPath: "backdropPath",
    episodeRunTime: [25],
    firstAirDate: DateTime.parse('2024-12-31'),
    genres: [
      GenreTvShowModel(id: 1, name: "genre1"),
      GenreTvShowModel(id: 2, name: "genre2"),
    ],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["US"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    seasons: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 1,
    voteCount: 1,
  );

  final tvShowDetail = TvShowDetail(
    adult: false,
    backdropPath: "backdropPath",
    episodeRunTime: [25],
    firstAirDate: DateTime.parse('2024-12-31'),
    genres: [
      GenreTvShowModel(id: 1, name: "genre1"),
      GenreTvShowModel(id: 2, name: "genre2"),
    ],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["US"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    seasons: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowDetailModelA = TvShowDetailResponse(
    adult: false,
    backdropPath: "backdropPath",
    episodeRunTime: [25],
    firstAirDate: DateTime.parse('2024-12-31'),
    genres: [
      GenreTvShowModel(id: 1, name: "genre1"),
      GenreTvShowModel(id: 2, name: "genre2"),
    ],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["US"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    seasons: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowDetailModelB = TvShowDetailResponse(
    adult: false,
    backdropPath: "backdropPath",
    episodeRunTime: [25],
    firstAirDate: DateTime.parse('2024-12-31'),
    genres: [
      GenreTvShowModel(id: 1, name: "genre1"),
      GenreTvShowModel(id: 2, name: "genre2"),
    ],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["US"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    seasons: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowDetailModelC = TvShowDetailResponse(
    adult: true,
    backdropPath: "backdropPath",
    episodeRunTime: [25],
    firstAirDate: DateTime.parse('2024-12-31'),
    genres: [
      GenreTvShowModel(id: 1, name: "genre1"),
      GenreTvShowModel(id: 2, name: "genre2"),
    ],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["US"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    seasons: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 1,
    voteCount: 1,
  );

  group('TV Show Detail toEntity', () {
    test('Should be a subclass of TV Show Entity', () {
      final result = tTvShowDetailResponse.toEntity();
      expect(result, tvShowDetail);
    });
  });

  group('TV Show prop', () {
    test('should be equal when props are the same', () {
      expect(tTvShowDetailModelA, equals(tTvShowDetailModelB));
    });
    test('should be not equal when props are the same', () {
      expect(tTvShowDetailModelA, isNot(equals(tTvShowDetailModelC)));
    });
  });

}
