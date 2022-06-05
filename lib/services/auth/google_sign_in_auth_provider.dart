import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/services/auth/auth_exceptions.dart';
import 'package:gigaturnip/services/auth/auth_provider.dart';
import 'package:gigaturnip/services/auth/auth_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser() async {
    return logIn();
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromGoogle(user);
    } else {
      return null;
    }
  }

  @override
  Future<String> getAccessToken() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.getIdToken();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> logIn() async {
    try {
      final googleUser = await GoogleSignIn(clientId: DefaultFirebaseOptions.clientIDWeb).signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      // TODO: Handle Firebase exceptions;
      rethrow;
    } catch (e) {
      throw GenericAuthException;
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
