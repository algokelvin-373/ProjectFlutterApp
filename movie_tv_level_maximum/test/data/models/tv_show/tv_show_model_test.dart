import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_model.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';

void main() {
  final tTvShowModel = TvShowModel(
    adult: false,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['', ''],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.1,
    posterPath: "posterPath",
    firstAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShow = TvShow(
    adult: false,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['', ''],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.1,
    posterPath: "posterPath",
    firstAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    voteAverage: 1,
    voteCount: 1,
  );

  test('Should be a subclass of TV Show Entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
