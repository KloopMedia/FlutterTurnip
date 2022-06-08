import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthUser> _userSubscription;

  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required GigaTurnipRepository gigaTurnipRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppStateLoggedIn(user: authenticationRepository.currentUser)
              : AppStateLoggedOut(exception: null),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppLoginRequested>(_onLoginRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    if (event.user.isNotEmpty) {
      emit(AppStateLoggedIn(user: event.user));
    } else {
      emit(AppStateLoggedOut(exception: null));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onLoginRequested(AppLoginRequested event, Emitter<AppState> emit) {
    emit(AppStateLoggedOut(exception: null));
    try {
      _authenticationRepository.logInWithGoogle();
    } on LogInWithGoogleFailure catch (e) {
      emit(AppStateLoggedOut(exception: e));
    } catch (e) {
      emit(AppStateLoggedOut(exception: const LogInWithGoogleFailure()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
