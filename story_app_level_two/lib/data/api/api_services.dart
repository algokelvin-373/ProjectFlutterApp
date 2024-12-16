import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:story_app_level_two/data/model/login/login_request.dart';
import 'package:story_app_level_two/data/model/login/login_response.dart';
import 'package:story_app_level_two/data/model/register/register_request.dart';
import 'package:story_app_level_two/data/model/register/register_response.dart';
import 'package:story_app_level_two/data/model/story/story_detail_response.dart';
import 'package:story_app_level_two/data/model/upload/upload_story_request.dart';

import '../model/story/story_list_response.dart';
import '../model/upload/upload_story_response.dart';

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

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/register"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': request.name,
        'email': request.email,
        'password': request.password,
      }),
    );

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(responseData);
    } else {
      return RegisterResponse(
        error: responseData['error'],
        message: responseData['message'],
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

  Future<UploadStoryResponse> uploadStory(
    String token,
    UploadStoryRequest uploadStoryRequest,
  ) async {
    final uri = Uri.parse("$_baseUrl/stories");
    var request = http.MultipartRequest('POST', uri);

    final imgBytes = uploadStoryRequest.bytes;
    final fileName = uploadStoryRequest.fileName;
    final description = uploadStoryRequest.description;

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      imgBytes,
      filename: fileName,
    );

    final Map<String, String> fields = {"description": description};
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token",
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    // Set Body for Data Location (lat, lon)
    final lat = uploadStoryRequest.lat;
    final lon = uploadStoryRequest.lng;
    if (lat != 0.0 && lon != 0.0) {
      print('Masuk If get lat lon');
      final Map<String, String> location = {
        "lat": lat.toString(),
        "lon": lon.toString(),
      };
      request.fields.addAll(location);
    }

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);
    print(jsonDecode(responseData));
    if (statusCode == 200 || statusCode == 201) {
      return UploadStoryResponse.fromJson(responseData);
    } else {
      final json = jsonDecode(responseData);
      return UploadStoryResponse(
        error: json['error'],
        message: json['message'],
      );
    }
  }
}
