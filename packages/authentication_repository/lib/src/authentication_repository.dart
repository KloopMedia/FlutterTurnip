import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

import 'models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();

  User _user(firebase_auth.User? user) => user?.toUser ?? User.empty;

  Stream<User> get userStream {
    return _firebaseAuth.authStateChanges().map((firebaseUser) => _user(firebaseUser));
  }

  User get user => _user(_firebaseAuth.currentUser);

  Future<String?> get token async => await _firebaseAuth.currentUser?.getIdToken();

  Future<void> signInWithCredential(firebase_auth.AuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> logInWithGoogle() async {
    late final firebase_auth.AuthCredential credential;
    if (kIsWeb) {
      final googleProvider = firebase_auth.GoogleAuthProvider();
      googleProvider.setCustomParameters({'prompt': 'select_account'});
      await _firebaseAuth.signInWithPopup(googleProvider);
    } else {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    }
  }

  Future<void> logInWithApple() async {
    final appleProvider = firebase_auth.AppleAuthProvider();
    if (kIsWeb) {
      await _firebaseAuth.signInWithPopup(appleProvider);
    } else {
      await _firebaseAuth.signInWithProvider(appleProvider);
    }
  }

  Future<void> logInWithPhone({
    required String phoneNumber,
    required void Function(firebase_auth.PhoneAuthCredential) verificationCompleted,
    required void Function(firebase_auth.FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  Future<firebase_auth.ConfirmationResult> logInWithPhoneWeb(String phoneNumber) async {
    return await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
  }

  Future<void> logOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
