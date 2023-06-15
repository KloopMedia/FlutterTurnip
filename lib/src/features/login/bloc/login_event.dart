part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class CloseOnBoarding extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginWithAuthProvider extends LoginEvent {
  final AuthProvider provider;

  const LoginWithAuthProvider(this.provider);

  @override
  List<Object> get props => [provider];
}

class SendOTP extends LoginEvent {
  final String verificationId;
  final int? resendToken;

  const SendOTP(this.verificationId, this.resendToken);

  @override
  List<Object?> get props => [verificationId, resendToken];
}

class ConfirmOTP extends LoginEvent {
  final String smsCode;
  final String verificationId;

  const ConfirmOTP(this.smsCode, this.verificationId);

  @override
  List<Object?> get props => [smsCode, verificationId];
}

class CompleteVerification extends LoginEvent {
  final PhoneAuthCredential credential;

  const CompleteVerification(this.credential);

  @override
  List<Object?> get props => [credential];
}
