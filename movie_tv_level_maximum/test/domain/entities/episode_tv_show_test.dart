import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/episode_tv_show.dart';

import '../../json_reader.dart';

void main() {
  final tEpisodeTvShow = EpisodeTvShow(
    airDate: DateTime.parse("2024-12-23"),
    episodeNumber: 1,
    episodeType: "regular",
    id: 101,
    name: "Episode 1",
    overview: "This is episode 1.",
    productionCode: "P001",
    runtime: 42,
    seasonNumber: 1,
    showId: 1001,
    stillPath: "/path/to/image.jpg",
    voteAverage: 8.5,
    voteCount: 1000,
  );

  group('from JSON Episode TV Show', () {
    test('Should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/episode_tv_show.json'));
      final result = EpisodeTvShow.fromJson(jsonMap);
      expect(result.airDate, tEpisodeTvShow.airDate);
      expect(result.episodeNumber, tEpisodeTvShow.episodeNumber);
      expect(result.episodeType, tEpisodeTvShow.episodeType);
      expect(result.id, tEpisodeTvShow.id);
      expect(result.name, tEpisodeTvShow.name);
      expect(result.overview, tEpisodeTvShow.overview);
      expect(result.productionCode, tEpisodeTvShow.productionCode);
      expect(result.runtime, tEpisodeTvShow.runtime);
      expect(result.seasonNumber, tEpisodeTvShow.seasonNumber);
      expect(result.showId, tEpisodeTvShow.showId);
      expect(result.stillPath, tEpisodeTvShow.stillPath);
      expect(result.voteAverage, tEpisodeTvShow.voteAverage);
      expect(result.voteCount, tEpisodeTvShow.voteCount);
    });
  });

  group('to JSON Episode TV Show', () {
    test('Should return a JSON Map', () async {
      final result = tEpisodeTvShow.toJson();

      final expectedJsonMap = {
        "air_date": "2024-12-23",
        "episode_number": 1,
        "episode_type": "regular",
        "id": 101,
        "name": "Episode 1",
        "overview": "This is episode 1.",
        "production_code": "P001",
        "runtime": 42,
        "season_number": 1,
        "show_id": 1001,
        "still_path": "/path/to/image.jpg",
        "vote_average": 8.5,
        "vote_count": 1000
      };

      expect(result, expectedJsonMap);
    });
  });
}
