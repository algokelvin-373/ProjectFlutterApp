import 'package:story_app_level_two/data/model/login/login_response.dart';
import 'package:story_app_level_two/data/model/register/register_response.dart';

sealed class AuthResultState {}

class AuthNoneState extends AuthResultState {}

class AuthLoadingState extends AuthResultState {}

class AuthLoadedState extends AuthResultState {
  final LoginResponse response;
  AuthLoadedState(this.response);
}

class RegisterLoadedState extends AuthResultState {
  final RegisterResponse response;
  RegisterLoadedState(this.response);
}

class AuthErrorState extends AuthResultState {
  final String error;
  AuthErrorState(this.error);
}
