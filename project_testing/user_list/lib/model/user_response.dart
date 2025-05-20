import 'package:mobile_flutter/model/user.dart';

class UserResponse {
  final List<User> users;

  UserResponse({
    required this.users,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    var userList = (json['data'] as List)
        .map((user) => User.fromJson(user))
        .toList();

    return UserResponse(
      users: userList,
    );
  }
}