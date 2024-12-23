import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_tv_level_maximum/data/data_sources/db/database_helper.dart';
import 'package:movie_tv_level_maximum/data/models/movie/movie_table.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_table.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../dummy_data/dummy_objects.dart';

//@GenerateMocks([DatabaseHelper])
void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    databaseHelper = DatabaseHelper();
  });

  group('DatabaseHelper Movie Tests', () {
    final movie1 = MovieTable(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: 'posterPath',
    );

    final movie10 = MovieTable(
      id: 10,
      title: 'Movie 10',
      overview: 'Overview 10',
      posterPath: 'PosterPath 10',
    );

    final movie20 = MovieTable(
      id: 20,
      title: 'Movie 20',
      overview: 'Overview 20',
      posterPath: 'PosterPath 20',
    );

    test('Should create database successfully', () async {
      final db = await databaseHelper.database;
      expect(db, isNotNull);
    });

    test('Should insert movie into watchlist', () async {
      final result = await databaseHelper.insertWatchlist(movie1);
      expect(result, 1);
    });

    test('Should retrieve movie by ID', () async {
      final result = await databaseHelper.getMovieById(1);
      expect(result, isNotNull);
      expect(result!['id'], 1);
      expect(result['title'], 'title');
    });

    test('Should remove movie into watchlist', () async {
      final result = await databaseHelper.removeWatchlist(movie1);
      expect(result, 1);
      final check = await databaseHelper.getMovieById(movie1.id);
      expect(check, isNull);
    });

    test('Should retrieve all movies in watchlist', () async {
      await databaseHelper.insertWatchlist(movie10);
      await databaseHelper.insertWatchlist(movie20);

      final results = await databaseHelper.getWatchlistMovies();
      expect(results.length, 2);
    });

    final tvShow1 = TvShowTable(
      id: 1,
      name: "name 1",
      posterPath: "posterPath 1",
      overview: "overview 1",
    );

    final tvShow10 = TvShowTable(
      id: 10,
      name: "name 10",
      posterPath: "posterPath 10",
      overview: "overview 10",
    );

    final tvShow20 = TvShowTable(
      id: 20,
      name: "name 20",
      posterPath: "posterPath 20",
      overview: "overview 20",
    );

    test('Should insert tv show into watchlist', () async {
      final result = await databaseHelper.insertWatchlistTvShow(tvShow1);
      expect(result, 1);
    });

    test('Should retrieve tv show by ID', () async {
      final result = await databaseHelper.getTvShowById(tvShow1.id);
      expect(result, isNotNull);
      expect(result!['id'], 1);
      expect(result['name'], 'name 1');
    });

    test('Should remove tv show into watchlist', () async {
      final result = await databaseHelper.removeWatchlistTvShow(tvShow1);
      expect(result, 1);
      final check = await databaseHelper.getMovieById(tvShow1.id);
      expect(check, isNull);
    });

    test('Should retrieve all tv shows in watchlist', () async {
      await databaseHelper.insertWatchlistTvShow(tvShow10);
      await databaseHelper.insertWatchlistTvShow(tvShow20);

      final results = await databaseHelper.getWatchlistTvShows();
      expect(results.length, 2);
    });
  });
}
