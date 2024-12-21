import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/exception.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_local_data_source.dart';
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_remote_data_source.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_model.dart';
import 'package:movie_tv_level_maximum/data/repositories/tv_show_repository_impl.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_repository_impl_test.mocks.dart';

@GenerateMocks([TvShowRemoteDataSource, TvShowLocalDataSource])
void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockTvShowRemoteDataSource;
  late MockTvShowLocalDataSource mockTvShowLocalDataSource;

  setUp(() {
    mockTvShowRemoteDataSource = MockTvShowRemoteDataSource();
    mockTvShowLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockTvShowRemoteDataSource,
      localDataSource: mockTvShowLocalDataSource,
    );
  });

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

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Airing Today TV Shows', () {
    test('Should return remote data when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getAiringTodayTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      final result = await repository.getAiringTodayTvShow();
      verify(mockTvShowRemoteDataSource.getAiringTodayTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('Should return server failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getAiringTodayTvShow())
          .thenThrow(ServerException());
      final result = await repository.getAiringTodayTvShow();
      verify(mockTvShowRemoteDataSource.getAiringTodayTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.getAiringTodayTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getAiringTodayTvShow();
      verify(mockTvShowRemoteDataSource.getAiringTodayTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('On The Air TV Shows', () {
    test('Should return remote data when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getOnTheAirTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      final result = await repository.getOnTheAirTvShow();
      verify(mockTvShowRemoteDataSource.getOnTheAirTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('Should return server failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getOnTheAirTvShow())
          .thenThrow(ServerException());
      final result = await repository.getOnTheAirTvShow();
      verify(mockTvShowRemoteDataSource.getOnTheAirTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.getOnTheAirTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getOnTheAirTvShow();
      verify(mockTvShowRemoteDataSource.getOnTheAirTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Shows', () {
    test('Should return remote data when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getPopularTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      final result = await repository.getPopularTvShow();
      verify(mockTvShowRemoteDataSource.getPopularTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('Should return server failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getPopularTvShow())
          .thenThrow(ServerException());
      final result = await repository.getPopularTvShow();
      verify(mockTvShowRemoteDataSource.getPopularTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.getPopularTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getPopularTvShow();
      verify(mockTvShowRemoteDataSource.getPopularTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated TV Shows', () {
    test('Should return remote data when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getTopRatedTvShow())
          .thenAnswer((_) async => tTvShowModelList);
      final result = await repository.getTopRatedTvShow();
      verify(mockTvShowRemoteDataSource.getTopRatedTvShow());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('Should return server failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getTopRatedTvShow())
          .thenThrow(ServerException());
      final result = await repository.getTopRatedTvShow();
      verify(mockTvShowRemoteDataSource.getTopRatedTvShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.getTopRatedTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getTopRatedTvShow();
      verify(mockTvShowRemoteDataSource.getTopRatedTvShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Show Detail', () {
    final tId = 1;

    /*test('Should return TV Show Detail when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      final result = await repository.getTvShowDetail(tId);
      verify(mockTvShowRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });*/

    test('Should return Server Failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      final result = await repository.getTvShowDetail(tId);
      verify(mockTvShowRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getTvShowDetail(tId);
      verify(mockTvShowRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Show Recommendation', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('Should return remote data when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getTvShowRecommendation(tId))
          .thenAnswer((_) async => tTvShowList);
      final result = await repository.getTvShowRecommendations(tId);
      verify(mockTvShowRemoteDataSource.getTvShowRecommendation(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('Should return server failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.getTvShowRecommendation(tId))
          .thenThrow(ServerException());
      final result = await repository.getTvShowRecommendations(tId);
      verify(mockTvShowRemoteDataSource.getTvShowRecommendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.getTvShowRecommendation(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getTvShowRecommendations(tId);
      verify(mockTvShowRemoteDataSource.getTvShowRecommendation(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV Show', () {
    final tQuery = "Avatar";

    test('Should return remote data when success call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.searchTvShow(tQuery))
          .thenAnswer((_) async => tTvShowModelList);
      final result = await repository.searchTvShows(tQuery);
      verify(mockTvShowRemoteDataSource.searchTvShow(tQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('Should return server failure when failed call remote data source',
        () async {
      when(mockTvShowRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(ServerException());
      final result = await repository.searchTvShows(tQuery);
      verify(mockTvShowRemoteDataSource.searchTvShow(tQuery));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('Should return connection failure when the device is not connected',
        () async {
      when(mockTvShowRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.searchTvShows(tQuery);
      verify(mockTvShowRemoteDataSource.searchTvShow(tQuery));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Save Watchlist TV Show', () {
    test('Should return success message when saving successful', () async {
      when(mockTvShowLocalDataSource.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist Tv Show');
      final result = await repository.saveWatchlistTvShow(testTvShowDetail);
      expect(result, Right('Added to Watchlist Tv Show'));
    });

    test('Should return DatabaseFailure when saving unsuccessful', () async {
      when(mockTvShowLocalDataSource.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await repository.saveWatchlistTvShow(testTvShowDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist TV Show', () {
    test('Should return remove message when remove successful', () async {
      when(mockTvShowLocalDataSource.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 'Removed from Watchlist Tv Show');
      final result = await repository.removeWatchlistTvShow(testTvShowDetail);
      expect(result, Right('Removed from Watchlist Tv Show'));
    });

    test('Should return DatabaseFailure when remove unsuccessful', () async {
      when(mockTvShowLocalDataSource.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await repository.removeWatchlistTvShow(testTvShowDetail);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Status Watchlist TV Show', () {
    test('Should return watch status whether data is found', () async {
      final tId = 1;
      when(mockTvShowLocalDataSource.getTvShowById(tId))
          .thenAnswer((_) async => null);
      final result = await repository.isAddedToWatchlistTvShow(tId);
      expect(result, false);
    });
  });

  group('Get Watchlist TV Shows', () {
    test('Should return list of TV Shows', () async {
      // arrange
      when(mockTvShowLocalDataSource.getWatchlistTvShow())
          .thenAnswer((_) async => [testTvShowTable]);
      final result = await repository.getWatchlistTvShow();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}
