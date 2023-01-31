part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class TryToLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}

