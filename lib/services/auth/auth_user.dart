import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String uid;
  final String? email;

  const AuthUser({required this.uid, required this.email});

  factory AuthUser.fromGoogle(User user) => AuthUser(uid: user.uid, email: user.email);
}