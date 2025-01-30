import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_flutter/service/user_service.dart';

import '../../model/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userService.fetchUsers(event.page);
        emit(UserLoaded(response.users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
