import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventRegister extends AuthEvent {
  const AuthEventRegister();
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventLogIn extends AuthEvent {
  const AuthEventLogIn();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
