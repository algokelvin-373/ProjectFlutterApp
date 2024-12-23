import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';

void main() {
  final tTvShowEpisode = TvShowEpisode(
    id: "1",
    airDate: DateTime.parse('2024-12-31'),
    episodes: [],
    name: "name",
    overview: "overview",
    tvShowEpisodeResponseId: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  group('TV Show Episode toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvShowEpisode.toJson();
      final expectedJsonMap = {
        'id': "1",
        'airDate': DateTime.parse('2024-12-31'),
        'episodes': [],
        'name': "name",
        'overview': "overview",
        'tvShowEpisodeResponseId': 1,
        'poster_path': "posterPath",
        'season_number': 1,
        'vote_average': 1.0,
      };
      expect(result, expectedJsonMap);
    });
  });

  group('TV Show Episode Model toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvShowEpisode.toJson();
      final expectedJsonMap = {
        'id': "1",
        'airDate': DateTime.parse('2024-12-31'),
        'episodes': [],
        'name': "name",
        'overview': "overview",
        'tvShowEpisodeResponseId': 1,
        'poster_path': "posterPath",
        'season_number': 1,
        'vote_average': 1.0,
      };
      expect(result, expectedJsonMap);
    });
  });
}
