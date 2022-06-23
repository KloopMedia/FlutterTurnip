import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthUser> _userSubscription;

  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required GigaTurnipRepository gigaTurnipRepository,
  })
      : _authenticationRepository = authenticationRepository,
        super(
        authenticationRepository.currentUser.isNotEmpty
            ? AppStateLoggedIn(user: authenticationRepository.currentUser)
            : const AppStateLoggedOut(exception: null),
      ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLocaleChanged>(_onLocaleChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppLoginRequested>(_onLoginRequested);
    on<AppSelectedCampaignChanged>(_onSelectedCampaignChanged);
    on<AppSelectedTaskChanged>(_onSelectedTaskChanged);
    _userSubscription = _authenticationRepository.user.listen(
          (user) => add(AppUserChanged(user)),
    );
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    if (event.user.isNotEmpty) {
      emit(AppStateLoggedIn(user: event.user));
    } else {
      emit(const AppStateLoggedOut(exception: null));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onLoginRequested(AppLoginRequested event, Emitter<AppState> emit) async {
    emit(const AppStateLoggedOut(exception: null));
    try {
      await _authenticationRepository.logInWithGoogle();
    } on LogInWithGoogleFailure catch (e) {
      emit(AppStateLoggedOut(exception: e));
    } catch (e) {
      emit(const AppStateLoggedOut(exception: LogInWithGoogleFailure()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  void _onSelectedCampaignChanged(AppSelectedCampaignChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(campaign: event.campaign));
  }

  void _onSelectedTaskChanged(AppSelectedTaskChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(task: event.task));
  }

  void _onLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(appLocale: event.locale));
  }
}
