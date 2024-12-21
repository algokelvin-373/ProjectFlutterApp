import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_airing_today.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_on_the_air.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_popular.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_top_rated.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_list_notifier.dart';

import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvShow,
  GetOnTheAirTvShow,
  GetPopularTvShow,
  GetTopRatedTvShow
])
void main() {
  late TvShowListNotifier provider;
  late MockGetAiringTodayTvShow mockGetAiringTodayTvShow;
  late MockGetOnTheAirTvShow mockGetOnTheAirTvShow;
  late MockGetPopularTvShow mockGetPopularTvShow;
  late MockGetTopRatedTvShow mockGetTopRatedTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvShow = MockGetAiringTodayTvShow();
    mockGetOnTheAirTvShow = MockGetOnTheAirTvShow();
    mockGetPopularTvShow = MockGetPopularTvShow();
    mockGetTopRatedTvShow = MockGetTopRatedTvShow();
    provider = TvShowListNotifier(
      getAiringTodayTvShow: mockGetAiringTodayTvShow,
      getOnTheAirTvShow: mockGetOnTheAirTvShow,
      getPopularTvShow: mockGetPopularTvShow,
      getTopRatedTvShow: mockGetTopRatedTvShow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

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

  final tTvShowList = <TvShow>[tTvShow];

  group('Airing Today TV Shows', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('Should get data from the use case', () async {
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      provider.fetchAiringTodayTvShows();
      verify(mockGetAiringTodayTvShow.execute());
    });

    test('Should change state to Loading when use case is called', () {
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      provider.fetchAiringTodayTvShows();
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('Should change tv shows when data is gotten successfully', () async {
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      await provider.fetchAiringTodayTvShows();
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      when(mockGetAiringTodayTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await provider.fetchAiringTodayTvShows();
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
