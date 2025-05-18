import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/episode_tv_show_model.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/episode_tv_show.dart';

void main() {
  final tEpisodeTvShow = EpisodeTvShowModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeNumber: 1,
    episodeType: "episodeType",
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final episodeTvShow = EpisodeTvShow(
    airDate: DateTime.parse('2024-12-31'),
    episodeNumber: 1,
    episodeType: "episodeType",
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Episode TV Show toEntity', () {
    test('Should be a subclass of TV Show Entity', () {
      final result = tEpisodeTvShow.toEntity();
      expect(result, episodeTvShow);
    });
  });

  final episodeTvShowModel = EpisodeTvShowModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeNumber: 1,
    episodeType: "episodeType",
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final episodeTvShowModelA = EpisodeTvShowModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeNumber: 1,
    episodeType: "episodeType",
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final episodeTvShowModelB = EpisodeTvShowModel(
    airDate: DateTime.parse('2024-12-31'),
    episodeNumber: 2,
    episodeType: "episodeType",
    id: 2,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Episode TV Show prop', () {
    test('should be equal when props are the same', () {
      expect(episodeTvShowModel, equals(episodeTvShowModelA));
    });
    test('should be not equal when props are the same', () {
      expect(episodeTvShowModel, isNot(equals(episodeTvShowModelB)));
    });
  });
}
