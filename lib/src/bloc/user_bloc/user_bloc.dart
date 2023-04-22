import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marker/src/models/user_model.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(user: User())) {
    on<UserEventLogin>((event, emit) {
      User userState = User(
          message: event.user.message,
          email: event.user.email,
          token: event.user.token);
      emit(state.copyWith(user: userState));
    });
  }
}
