import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_detail_response.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_episodes_response.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';

void main() {
  final tTvShowEpisodesResponse = TvShowEpisodeResponse(
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

  final tvShowEpisode = TvShowEpisode(
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

  group('TV Show Episodes Response toEntity', () {
    test('Should be a subclass of TV Show Episodes Response Entity', () {
      final result = tTvShowEpisodesResponse.toEntity();
      expect(result.id, tvShowEpisode.id);
      expect(result.airDate, tvShowEpisode.airDate);
      expect(result.episodes, tvShowEpisode.episodes);
      expect(result.name, tvShowEpisode.name);
      expect(result.overview, tvShowEpisode.overview);
      expect(result.tvShowEpisodeResponseId, tvShowEpisode.tvShowEpisodeResponseId);
      expect(result.posterPath, tvShowEpisode.posterPath);
      expect(result.seasonNumber, tvShowEpisode.seasonNumber);
      expect(result.voteAverage, tvShowEpisode.voteAverage);
    });
  });
}
