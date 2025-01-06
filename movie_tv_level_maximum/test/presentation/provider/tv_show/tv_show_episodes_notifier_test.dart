import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_episodes.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_episodes_notifier.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_episodes_notifier_test.mocks.dart';

@GenerateMocks([GetTvShowEpisodes])
void main() {
  late TvShowEpisodesNotifier provider;
  late MockGetTvShowEpisodes mockGetTvShowEpisodes;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowEpisodes = MockGetTvShowEpisodes();
    provider = TvShowEpisodesNotifier(
      getTvShowEpisodes: mockGetTvShowEpisodes,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;
  final tSeason = 1;

  void arrangeUseCase() {
    when(mockGetTvShowEpisodes.execute(tId, tSeason))
        .thenAnswer((_) async => Right(testTvShowEpisodes));
  }

  group('Get TV Show Episodes', () {
    test('Should get data from the use case', () async {
      arrangeUseCase();
      await provider.fetchTvShowEpisodes(tId, tSeason);
      verify(mockGetTvShowEpisodes.execute(tId, tSeason));
    });

    test('Should change state to Loading when use case is called', () {
      arrangeUseCase();
      provider.fetchTvShowEpisodes(tId, tSeason);
      expect(provider.tvShowEpisodeState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('Should change tv show when data is gotten successfully', () async {
      arrangeUseCase();
      await provider.fetchTvShowEpisodes(tId, tSeason);
      expect(provider.tvShowEpisodeState, RequestState.Loaded);
      expect(provider.tvShowEpisode, testTvShowEpisodes);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetTvShowEpisodes.execute(tId, tSeason))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await provider.fetchTvShowEpisodes(tId, tSeason);
      expect(provider.tvShowEpisodeState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
