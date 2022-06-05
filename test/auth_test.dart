import 'package:gigaturnip/services/auth/auth_exceptions.dart';
import 'package:gigaturnip/services/auth/auth_provider.dart';
import 'package:gigaturnip/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initialized', () {
      expect(provider.logOut(), throwsA(const TypeMatcher<NotInitializedException>()));
    });

    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test('Test should be initialized in less than 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test('Create user should delegate to logIn function', () async {
      final user = await provider.createUser();
      expect(provider.currentUser, user);
    });

    test('Should be able to log out and log in', () async {
      await provider.logOut();
      expect(provider.currentUser, isNull);

      await provider.logIn();
      expect(provider.currentUser, isNotNull);

    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;

  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser() async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 2));
    return logIn();
  }

  @override
  Future<String> getAccessToken() async {
    return '';
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn() {
    if (!isInitialized) throw NotInitializedException();
    const user = AuthUser(uid: '123', email: '123@gmail.com');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }
}
