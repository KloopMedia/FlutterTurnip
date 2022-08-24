import 'package:authentication_repository/src/cache_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:authentication_repository/authentication_repository.dart';

class AuthenticationRepository {
  final CacheClient _cache;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository({
    CacheClient? cache,
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  bool isWeb = kIsWeb;
  static const userCacheKey = '__user_cache_key__';
  static const tokenCacheKey = '__token_cache_key__';

  Stream<AuthUser> get user {
    return _firebaseAuth.idTokenChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AuthUser.empty : firebaseUser.toUser;
      _cache.write<AuthUser>(key: userCacheKey, value: user);
      return user;
    });
  }

  Future<String> get token async {
    final user = _firebaseAuth.currentUser;
    return user != null ? await user.getIdToken() : '';
  }

  AuthUser get currentUser {
    return _cache.read<AuthUser>(key: userCacheKey) ?? AuthUser.empty;
  }

  Future<void> logInWithGoogle() async {
    try {
      late final AuthCredential credential;
      if (isWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      print(_);
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      print(_);
      // TODO: Fix googleSignIn log out error
      throw LogOutFailure();
    }
  }
}

extension on User {
  AuthUser get toUser {
    return AuthUser(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
