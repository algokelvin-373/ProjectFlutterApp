import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app_level_two/data/model/login/login_request.dart';
import 'package:story_app_level_two/data/model/register/register_request.dart';
import 'package:story_app_level_two/data/model/register/register_response.dart';
import 'package:story_app_level_two/db/auth_repository.dart';
import 'package:story_app_level_two/static/auth_result.dart';

import '../../data/api/api_services.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiServices _apiServices;

  AuthProvider(this.authRepository, this._apiServices);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

  String _username = '';

  String get username => _username;

  RegisterResponse _responseRegister =
      RegisterResponse(error: false, message: "");

  AuthResultState _resultState = AuthNoneState();

  AuthResultState get resultState => _resultState;

  void setResultState(AuthResultState state) {
    _resultState = state;
    notifyListeners();
  }

  Future<void> login(LoginRequest request) async {
    _resultState = AuthLoadingState();
    isLoadingLogin = true;
    notifyListeners();

    try {
      final result = await _apiServices.login(request);

      if (result.error) {
        _resultState = AuthErrorState(result.message);
        isLoadingLogin = false;
        notifyListeners();
      } else {
        _resultState = AuthLoadedState(result);
        final token = result.loginResult?.token;
        final name = result.loginResult?.name;
        await authRepository.login();
        await authRepository.saveUser(name!);
        await authRepository.token(token!);
        isLoadingLogin = false;
        isLoggedIn = true;
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = AuthErrorState(e.toString());
      isLoadingLogin = false;
      notifyListeners();
    }
  }

  Future<void> register(RegisterRequest request) async {
    _resultState = AuthLoadingState();
    isLoadingRegister = true;
    notifyListeners();

    try {
      final result = await _apiServices.register(request);

      if (result.error) {
        _resultState = AuthErrorState(result.message);
        isLoadingRegister = false;
        notifyListeners();
      } else {
        _resultState = RegisterLoadedState(result);
        isLoadingRegister = false;
        notifyListeners();
      }
      _responseRegister = result;
    } on Exception catch (e) {
      _resultState = AuthErrorState(e.toString());
      isLoadingRegister = false;
      notifyListeners();
    }
  }

  Future<RegisterResponse> getResultRegister() async => _responseRegister;

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();
    final logout = await authRepository.logout();
    if (logout) {
      await authRepository.deleteUser();
      await authRepository.deleteToken();
    }
    isLoggedIn = await authRepository.isLoggedIn();
    isLoadingLogout = false;
    notifyListeners();
    return !isLoggedIn;
  }

  Future<void> loadUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    _username = preferences.getString("user") ?? "Guest";
    notifyListeners();
  }
}
