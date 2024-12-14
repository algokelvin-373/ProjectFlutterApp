import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/user.dart';

class AuthRepository {
  final String stateKey = "state";
  final String userKey = "user";
  final String tokenKey = "token";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.getBool(stateKey) ?? false;
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.getString(tokenKey) ?? "";
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setBool(stateKey, true);
  }

  Future<void> token(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    preferences.setString(tokenKey, token);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setBool(stateKey, false);
  }

  Future<void> saveUser(String name) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    preferences.setString(userKey, name);
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, "");
  }

  Future<bool> deleteToken() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(tokenKey, "");
  }
}
