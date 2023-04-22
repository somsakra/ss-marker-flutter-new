part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserEventLogin extends UserEvent {
  final User user;
  const UserEventLogin(this.user);
}
