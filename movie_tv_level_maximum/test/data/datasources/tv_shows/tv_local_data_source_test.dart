import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/exception.dart';
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_local_data_source.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save Watchlist TV Show', () {
    test('Should return success save TV Show in database', () async {
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.insertWatchlistTvShow(testTvShowTable);
      expect(result, 'Added to Watchlist Tv Show');
    });

    test('Should return DatabaseException when save to DB is failed', () async {
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      final call = dataSource.insertWatchlistTvShow(testTvShowTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist TV Show', () {
    test('Should return success remove TV Show in database', () async {
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.removeWatchlistTvShow(testTvShowTable);
      expect(result, 'Removed from Watchlist TV Show');
    });

    test('Should return DatabaseException when remove to DB is failed',
        () async {
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      final call = dataSource.removeWatchlistTvShow(testTvShowTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Show by ID', () {
    final tId = 1;

    test('Should return Get TV Show when data is found', () async {
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => testTvShowMap);
      final result = await dataSource.getTvShowById(tId);
      expect(result, testTvShowTable);
    });

    test('Should return null if TV Show is not found', () async {
      when(mockDatabaseHelper.getTvShowById(tId)).thenAnswer((_) async => null);
      final result = await dataSource.getTvShowById(tId);
      expect(result, null);
    });
  });

  group('Get Watchlist TV Show', () {
    test('Should return Watchlist TV Show from DB', () async {
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowMap]);
      final result = await dataSource.getWatchlistTvShow();
      expect(result, [testTvShowTable]);
    });
  });
}
