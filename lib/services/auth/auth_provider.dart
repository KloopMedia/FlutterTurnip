import 'package:gigaturnip/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<String> getAccessToken();

  Future<void> initialize();

  Future<AuthUser> logIn();

  Future<AuthUser> createUser();

  Future<void> logOut();
}