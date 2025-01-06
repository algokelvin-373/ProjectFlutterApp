import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_model.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_response.dart';

import '../../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
    adult: false,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ["", ""],
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

  final tTvShowResponseModel = TvShowResponse(
    tvShowList: <TvShowModel>[tTvShowModel],
    page: 1,
    totalPages: 1,
    totalResults: 1,
  );

  group('from JSON TV Show', () {
    test('Should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular_tv_show.json'));
      final result = TvShowResponse.fromJson(jsonMap);
      expect(result.page, tTvShowResponseModel.page);
      expect(result.tvShowList, tTvShowResponseModel.tvShowList);
      expect(result.totalPages, tTvShowResponseModel.totalPages);
      expect(result.totalResults, tTvShowResponseModel.totalResults);
    });
  });

  group('to JSON TV Show', () {
    test('Should return a JSON Map TV Show', () async {
      final result = tTvShowResponseModel.toJson();

      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "adult": false,
            "backdrop_path": "backdropPath",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "origin_country": ["", ""],
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1.1,
            "poster_path": "posterPath",
            "first_air_date": "2024-12-31",
            "name": "name",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
        "total_pages": 1,
        "total_results": 1
      };

      expect(result, expectedJsonMap);
    });
  });
}
