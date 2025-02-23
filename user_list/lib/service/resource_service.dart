import 'package:mobile_flutter/model/resource_response.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ResourceService {
  Future<ResourceResponse> fetchResources(int page) async {
    final response =
    await http.get(Uri.parse('https://reqres.in/api/{resource}?page=$page'));

    if (response.statusCode == 200) {
      return ResourceResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load resources');
    }
  }
}