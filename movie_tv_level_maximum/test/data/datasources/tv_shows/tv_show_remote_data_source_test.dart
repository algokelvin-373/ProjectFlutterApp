import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/exception.dart';
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_remote_data_source.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_response.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Airing Today TV Show', () {
    final url = '$baseUrl/tv/airing_today?$apiKey';
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_airing_today.json')))
        .tvShowList;

    test('Should return list of TV Show Model when response code is 200',
        () async {

      when(mockHttpClient.get(Uri.parse(url))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_airing_today.json'), 200));

      final result = await dataSource.getAiringTodayTvShow();
      expect(result, equals(tTvShowList));
    });

    test('Should throw a ServerException when response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getAiringTodayTvShow();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get On The Air TV Show', () {
    final url = '$baseUrl/tv/on_the_air?$apiKey';
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_on_the_air.json')))
        .tvShowList;

    test('Should return list of TV Show Model when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse(url))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_on_the_air.json'), 200));

      final result = await dataSource.getOnTheAirTvShow();
      expect(result, equals(tTvShowList));
    });

    test('Should throw a ServerException when response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getOnTheAirTvShow();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular TV Show', () {
    final url = '$baseUrl/tv/popular?$apiKey';
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_popular.json')))
        .tvShowList;

    test('Should return list of TV Show Model when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse(url))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_popular.json'), 200));

      final result = await dataSource.getPopularTvShow();
      expect(result, equals(tTvShowList));
    });

    test('Should throw a ServerException when response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getPopularTvShow();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV Show', () {
    final url = '$baseUrl/tv/top_rated?$apiKey';
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_top_rated.json')))
        .tvShowList;

    test('Should return list of TV Show Model when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse(url))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_top_rated.json'), 200));

      final result = await dataSource.getTopRatedTvShow();
      expect(result, equals(tTvShowList));
    });

    test('Should throw a ServerException when response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedTvShow();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Detail', () {
    
  });

  group('Get TV Show Recommendations', () {

  });

  group('Search TV Show', () {

  });

  group('Get Season and All Episodes', () {

  });
}
