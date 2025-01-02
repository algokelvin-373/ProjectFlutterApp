import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_recommendations.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_watchlist_tv_show_status.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/remove_watchlist_tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/save_watchlist_tv_show.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_detail_notifier.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListTvShowStatus,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchListTvShowStatus mockGetWatchlistTvShowStatus;
  late MockSaveWatchlistTvShow mockSaveWatchlistTvShow;
  late MockRemoveWatchlistTvShow mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistTvShowStatus = MockGetWatchListTvShowStatus();
    mockSaveWatchlistTvShow = MockSaveWatchlistTvShow();
    mockRemoveWatchlist = MockRemoveWatchlistTvShow();
    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getWatchListTvShowStatus: mockGetWatchlistTvShowStatus,
      saveWatchlistTvShow: mockSaveWatchlistTvShow,
      removeWatchlistTvShow: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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

  void arrangeUseCase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShowList));
  }

  group('Get TV Show Detail', () {
    test('Should get data from the use case', () async {
      arrangeUseCase();
      await provider.fetchTvShowDetail(tId);
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('Should change state to Loading when use case is called', () {
      arrangeUseCase();
      provider.fetchTvShowDetail(tId);
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('Should change tv show when data is gotten successfully', () async {
      arrangeUseCase();
      await provider.fetchTvShowDetail(tId);
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'Should change recommendation tv shows when data is gotten successfully',
        () async {
      arrangeUseCase();
      await provider.fetchTvShowDetail(tId);
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShowList);
    });
  });

  group('Get TV Show Recommendations', () {
    test('Should get data from the use case', () async {
      arrangeUseCase();
      await provider.fetchTvShowDetail(tId);
      verify(mockGetTvShowRecommendations.execute(tId));
      expect(provider.tvShowRecommendations, tTvShowList);
    });

    test('Should update recommendation state when data is gotten successfully',
        () async {
      arrangeUseCase();
      await provider.fetchTvShowDetail(tId);
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShowList);
    });

    test('Should update error message when request in successful', () async {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      await provider.fetchTvShowDetail(tId);
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist TV Show', () {
    test('Should get the watchlist status', () async {
      when(mockGetWatchlistTvShowStatus.execute(1))
          .thenAnswer((_) async => true);
      await provider.loadWatchlistTvShowStatus(1);
      expect(provider.isAddedToWatchlistTvShow, true);
    });

    test('Should execute save watchlist when function called', () async {
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      await provider.addWatchlistTvShow(testTvShowDetail);
      verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
    });

    test('Should execute remove watchlist when function called', () async {
      when(mockRemoveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      await provider.removeFromWatchlist(testTvShowDetail);
      verify(mockRemoveWatchlist.execute(testTvShowDetail));
    });

    test('Should update watchlist status when add watchlist success', () async {
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist Tv Show'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      await provider.addWatchlistTvShow(testTvShowDetail);
      verify(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlistTvShow, true);
      expect(provider.watchlistTvShowMessage, 'Added to Watchlist Tv Show');
      expect(listenerCallCount, 1);
    });

    test('Should update watchlist message when add watchlist failed', () async {
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      await provider.addWatchlistTvShow(testTvShowDetail);
      expect(provider.watchlistTvShowMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShowList));
      await provider.fetchTvShowDetail(tId);
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
