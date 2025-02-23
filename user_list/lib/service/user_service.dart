import '../model/user_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserResponse> fetchUsers(int page) async {
    final response =
    await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }
}