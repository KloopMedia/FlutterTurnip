import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  final GigaTurnipApiClient _gigaTurnipApiClient;
  final SharedPreferences _sharedPreferences;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({
    required GigaTurnipApiClient gigaTurnipApiClient,
    required AuthenticationRepository authenticationRepository,
    required SharedPreferences sharedPreferences,
  })  : _authenticationRepository = authenticationRepository,
        _gigaTurnipApiClient = gigaTurnipApiClient,
        _sharedPreferences = sharedPreferences,
        super(const AuthState.unauthenticated()) {
    on<_AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    // on<RequestAccountDeletion>(_onRequestAccountDeletion);
    on<DeleteAccount>(_onDeleteAccount);
    _userSubscription = _authenticationRepository.userStream.listen(
      (user) => add(_AuthUserChanged(user)),
    );
  }

  void _onUserChanged(_AuthUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  // Future<void> _onRequestAccountDeletion(
  //   RequestAccountDeletion event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   final response = await _gigaTurnipApiClient.deleteUserInit();
  //   final pk = response.data['delete_pk'];
  //   emit(AccountDeletionRequested.clone(state as UserAuthenticated, pk));
  // }

  void _onDeleteAccount(DeleteAccount event, Emitter<AuthState> emit) async {
    emit(DeletingAccount(state.user));

    try {
      final response = await _gigaTurnipApiClient.deleteUserInit();
      final pk = response.data['delete_pk'];
      await _gigaTurnipApiClient.deleteUser(pk, {"artifact": _authenticationRepository.user.id});
    } catch (e) {
      print(e);
    }
    try {
      await _authenticationRepository.revokeToken();
    } on Exception catch (e) {
      print(e);
    }
    try {
      await _authenticationRepository.deleteUserAccount();
    } on Exception catch (e) {
      print(e);
    }
    try {
      await _sharedPreferences.clear();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
