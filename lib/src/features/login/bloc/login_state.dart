part of 'login_bloc.dart';

enum AuthProvider {
  google,
  apple,
}

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  final bool firstTime;

  const LoginInitial({required this.firstTime});

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  final String errorMessage;

  const LoginFailed(this.errorMessage);

  @override
  List<Object> get props => [];
}

class OTPCodeSend extends LoginState {
  final String verificationId;
  final int? resendToken;

  const OTPCodeSend(this.verificationId, this.resendToken);

  @override
  List<Object?> get props => [verificationId, resendToken];
}
