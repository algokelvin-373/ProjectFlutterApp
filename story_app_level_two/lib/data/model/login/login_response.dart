import 'package:json_annotation/json_annotation.dart';

import 'login_result.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool error;
  String message;
  LoginResult? loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
