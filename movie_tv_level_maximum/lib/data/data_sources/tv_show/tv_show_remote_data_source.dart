import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_detail_response.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_episodes_response.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_model.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_response.dart';

import '../../../common/exception.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getAiringTodayTvShow();
  Future<List<TvShowModel>> getOnTheAirTvShow();
  Future<List<TvShowModel>> getPopularTvShow();
  Future<List<TvShowModel>> getTopRatedTvShow();
  Future<TvShowDetailResponse> getTvShowDetail(int id);
  Future<List<TvShowModel>> searchTvShow(String query);
  Future<List<TvShowModel>> getTvShowRecommendation(int id);
  Future<TvShowEpisodeResponse> getAllEpisodes(int id, int season);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvShowRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<TvShowModel>> getAiringTodayTvShow() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getOnTheAirTvShow() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getPopularTvShow() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShow() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvShowDetailResponse> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> searchTvShow(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvShowEpisodeResponse> getAllEpisodes(int id, int season) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$id/season/$season?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowEpisodeResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
