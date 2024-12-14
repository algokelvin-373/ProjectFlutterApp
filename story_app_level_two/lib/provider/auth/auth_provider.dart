import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/model/login/login_request.dart';
import 'package:story_app_level_two/db/auth_repository.dart';
import 'package:story_app_level_two/static/auth_result.dart';

import '../../data/api/api_services.dart';
import '../../data/model/user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiServices _apiServices;

  AuthProvider(this.authRepository, this._apiServices);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

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
        await authRepository.login();
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

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();
    final logout = await authRepository.logout();
    if (logout) {
      await authRepository.deleteUser();
    }
    isLoggedIn = await authRepository.isLoggedIn();
    isLoadingLogout = false;
    notifyListeners();
    return !isLoggedIn;
  }

  Future<bool> saveUser(User user) async {
    isLoadingRegister = true;
    notifyListeners();
    final userState = await authRepository.saveUser(user);
    isLoadingRegister = false;
    notifyListeners();
    return userState;
  }
}
