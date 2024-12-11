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

      //isLoadingLogin = false;

      print('Result: ${result.message}');
      print('Result: ${result.loginResult.name}');
      print('Result: ${result.loginResult.token}');
      if (result.error) {
        print('Masuk error');
        _resultState = AuthErrorState(result.message);
        notifyListeners();
        //return false;
      } else {
        print('Masuk login');
        _resultState = AuthLoadedState(result);
        isLoggedIn = true;
        //isLoggedIn = await authRepository.isLoggedIn();
        //isLoadingLogin = false;
        notifyListeners();
        //return isLoggedIn;
      }
    } on Exception catch (e) {
      print('Masuk exception');
      _resultState = AuthErrorState(e.toString());
      notifyListeners();
      //return false;
    }


    /*isLoadingLogin = true;
    notifyListeners();
    final userState = await authRepository.getUser();
    if (user == userState) {
      await authRepository.login();
    }
    isLoggedIn = await authRepository.isLoggedIn();
    isLoadingLogin = false;
    notifyListeners();
    return isLoggedIn;*/
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