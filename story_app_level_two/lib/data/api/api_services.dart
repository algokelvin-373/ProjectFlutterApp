import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_app_level_two/data/model/login/login_request.dart';
import 'package:story_app_level_two/data/model/login/login_response.dart';

import '../model/restaurant_detail_response.dart';
import '../model/story/story_list_response.dart';
import '../model/restaurant_review_response.dart';
import '../model/review_request.dart';

class ApiServices {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResponse> login(LoginRequest request) async {
    print('masuk login services');
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': request.email,
        'password': request.password,
      }),
    );

    print('response: ${response.body}');
    print('response: ${response.statusCode}');

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponse.fromJson(responseData);
    } else {
      return LoginResponse(
        error: responseData['error'],
        message: responseData['message'],
        loginResult: null,
      );
    }
  }

  Future<StoryListResponse> getStoryList(String token) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    print('Response: $responseData');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return StoryListResponse.fromJson(responseData);
    } else {
      return StoryListResponse(
        error: responseData['error'],
        message: responseData['message'],
        listStory: [],
      );
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantReviewResponse> addRestaurantReview(
      ReviewRequest review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'id': review.id,
        'name': review.name,
        'review': review.review,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}
