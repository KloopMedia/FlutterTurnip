// import 'package:gigaturnip/services/auth/auth_provider.dart';
// import 'package:gigaturnip/services/auth/auth_user.dart';
// import 'package:gigaturnip/services/auth/google_sign_in_auth_provider.dart';
//
// class AuthService implements AuthProvider {
//   final AuthProvider provider;
//
//   const AuthService(this.provider);
//
//   factory AuthService.google() => AuthService(GoogleSignInAuthProvider());
//
//   @override
//   Future<AuthUser> createUser() => provider.createUser();
//
//   @override
//   AuthUser? get currentUser => provider.currentUser;
//
//   @override
//   String? get accessToken => provider.accessToken;
//
//   @override
//   Future<AuthUser> logIn() => provider.logIn();
//
//   @override
//   Future<void> logOut() => provider.logOut();
//
//   @override
//   Future<void> initialize() => provider.initialize();
// }