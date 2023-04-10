part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class TryToLogin extends LoginEvent {
  final AuthProvider provider;

  const TryToLogin(this.provider);

  @override
  List<Object> get props => [provider];
}
