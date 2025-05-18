import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_season_model.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_season.dart';

void main() {
  final tTvShowSeason = TvShowSeasonModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tvShowSeason = TvShowSeason(
    airDate: DateTime.parse('2024-12-31'),
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  group('TV Show Season toEntity', () {
    test('Should be a subclass of TV Show Entity', () {
      final result = tTvShowSeason.toEntity();
      expect(result, tvShowSeason);
    });
  });

  final tvShowSeasonModel = TvShowSeasonModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tvShowSeasonModelA = TvShowSeasonModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tvShowSeasonModelB = TvShowSeasonModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeCount: 2,
    id: 2,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  group('TV Show Season prop', () {
    test('should be equal when props are the same', () {
      expect(tvShowSeasonModel, equals(tvShowSeasonModelA));
    });
    test('should be not equal when props are the same', () {
      expect(tvShowSeasonModel, isNot(equals(tvShowSeasonModelB)));
    });
  });

}
