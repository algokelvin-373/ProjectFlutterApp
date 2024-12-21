import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/exception.dart';
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_remote_data_source.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_detail_response.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_episodes_response.dart';
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
    final tId = 246;
    final url = Uri.parse('$baseUrl/tv/$tId?$apiKey');
    final tTvShowDetail = TvShowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_detail.json')));

    test('Should return TV Show detail when response code is 200', () async {
      when(mockHttpClient.get(url)).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_detail.json'), 200));
      final result = await dataSource.getTvShowDetail(tId);
      expect(result.adult, equals(tTvShowDetail.adult));
      expect(result.backdropPath, equals(tTvShowDetail.backdropPath));
      expect(result.episodeRunTime, equals(tTvShowDetail.episodeRunTime));
      expect(result.firstAirDate, equals(tTvShowDetail.firstAirDate));
      expect(result.genres, equals(tTvShowDetail.genres));
      expect(result.homepage, equals(tTvShowDetail.homepage));
      expect(result.inProduction, equals(tTvShowDetail.inProduction));
      expect(result.languages, equals(tTvShowDetail.languages));
      expect(result.name, equals(tTvShowDetail.name));
      expect(result.originalName, equals(tTvShowDetail.originalName));
      expect(result.popularity, equals(tTvShowDetail.popularity));
      expect(result.posterPath, equals(tTvShowDetail.posterPath));
      expect(result.originCountry, equals(tTvShowDetail.originCountry));
      expect(result.voteAverage, equals(tTvShowDetail.voteAverage));
      expect(result.voteCount, equals(tTvShowDetail.voteCount));
    });

    test('Should throw Server Exception when response code is 404 or other',
        () async {
      when(mockHttpClient.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTvShowDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Recommendations', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_recommendations.json')))
        .tvShowList;
    final tId = 246;
    final url = Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey');

    test('Should return list TV Show Recommendation when response code is 200',
        () async {
      when(mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
          readJson('dummy_data/tv_show_recommendations.json'), 200));
      final result = await dataSource.getTvShowRecommendation(tId);
      expect(result, equals(tTvShowList));
    });

    test('Should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTvShowRecommendation(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search TV Show', () {
    final tSearchResult = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/search_avatar_tv_show.json')))
        .tvShowList;
    final tQuery = 'Avatar';
    final url = Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery');

    test('Should return list tv show based on search when response code is 200',
        () async {
      when(mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_avatar_tv_show.json'), 200));
      final result = await dataSource.searchTvShow(tQuery);
      expect(result, tSearchResult);
    });

    test('Should throw ServerException when response code is 404 or other',
        () async {
      when(mockHttpClient.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.searchTvShow(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Season and All Episodes', () {
    final tSeasonEpisodes = TvShowEpisodeResponse.fromJson(json
        .decode(readJson('dummy_data/season_episodes_avatar_tv_show.json')));
    final tId = 1;
    final tSeason = 1;
    final url = Uri.parse('$baseUrl/tv/$tId/season/$tSeason?$apiKey');

    test('Should return season episodes tv show when response code is 200',
        () async {
      when(mockHttpClient.get(url)).thenAnswer((_) async => http.Response(
          readJson('dummy_data/season_episodes_avatar_tv_show.json'), 200));
      final result = await dataSource.getAllEpisodes(tId, tSeason);
      expect(result.name, equals(tSeasonEpisodes.name));
      expect(result.voteAverage, equals(tSeasonEpisodes.voteAverage));
      expect(result.overview, equals(tSeasonEpisodes.overview));
      expect(result.episodes[0].name, equals(tSeasonEpisodes.episodes[0].name));
      expect(result.episodes[0].voteAverage,
          equals(tSeasonEpisodes.episodes[0].voteAverage));
      expect(result.episodes[0].overview,
          equals(tSeasonEpisodes.episodes[0].overview));
    });

    test('Should throw ServerException when response code is 404 or other',
        () async {
      when(mockHttpClient.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getAllEpisodes(tId, tSeason);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
