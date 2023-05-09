import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginWithAuthProvider>(_onLoginWithAuthProvider);
    on<SendOTP>(_onSendOTP);
    on<ConfirmOTP>(_onConfirmOTP);
    on<CompleteVerification>(_onCompleteVerification);
  }

  Future<void> _login(AuthProvider provider) async {
    switch (provider) {
      case AuthProvider.google:
        await _authenticationRepository.logInWithGoogle();
        break;
      case AuthProvider.apple:
        await _authenticationRepository.logInWithApple();
        break;
    }
  }

  void _onLoginWithAuthProvider(LoginWithAuthProvider event, Emitter<LoginState> emit) {
    final provider = event.provider;

    try {
      _login(provider);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  Future<void> _onSendOTP(SendOTP event, Emitter<LoginState> emit) async {
    final verificationId = event.verificationId;
    final resendToken = event.resendToken;

    emit(OTPCodeSend(verificationId, resendToken));
  }

  Future<void> _onConfirmOTP(ConfirmOTP event, Emitter<LoginState> emit) async {
    String smsCode = event.smsCode;
    String verificationId = event.verificationId;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    add(CompleteVerification(credential));
  }

  Future<void> _onCompleteVerification(
    CompleteVerification event,
    Emitter<LoginState> emit,
  ) async {
    final credential = event.credential;
    try {
      await _authenticationRepository.signInWithCredential(credential);
      emit(LoginSuccess());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(LoginFailed(e.toString()));
    }
  }
}
