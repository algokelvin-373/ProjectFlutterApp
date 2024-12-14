import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_app_level_two/data/model/login/login_request.dart';
import 'package:story_app_level_two/data/model/login/login_response.dart';
import 'package:story_app_level_two/data/model/story/story_detail_response.dart';

import '../model/story/story_list_response.dart';

class ApiServices {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': request.email, 'password': request.password}),
    );

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

  Future<StoryDetailResponse> getStoryDetail(String token, String id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return StoryDetailResponse.fromJson(responseData);
    } else {
      return StoryDetailResponse(
        error: responseData['error'],
        message: responseData['message'],
        story: null,
      );
    }
  }
}
