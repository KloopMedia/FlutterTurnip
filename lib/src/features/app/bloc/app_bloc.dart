import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthUser> userSubscription;
  AppLocales? sharedPrefsAppLocale;

  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required GigaTurnipRepository gigaTurnipRepository,
  })  : _authenticationRepository = authenticationRepository,
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
    on<AppSelectedNotificationChanged>(_onSelectedNotificationChanged);

    userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
    _getLocaleFromSharedPrefs();
  }

  Locale? get sharedPrefsLocale {
    switch (sharedPrefsAppLocale) {
      // case AppLocales.system:
      //   return const Locale('system');
      case AppLocales.russian:
        return const Locale('ru');
      case AppLocales.english:
        return const Locale('en');
      case AppLocales.kyrgyz:
        return const Locale('ky');
      default:
        return null;
    }
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
    if (event.provider == LoginProvider.google) {
      try {
        await _authenticationRepository.logInWithGoogle();
      } on LogInWithGoogleFailure catch (e) {
        emit(AppStateLoggedOut(exception: e));
      } catch (e) {
        emit(const AppStateLoggedOut(exception: LogInWithGoogleFailure()));
      }
    }
    if (event.provider == LoginProvider.apple) {
      try {
        await _authenticationRepository.logInWithApple();
      } catch (e) {
        emit(AppStateLoggedOut(exception: LogInWithGoogleFailure()));
      }
    }
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  void _onSelectedCampaignChanged(AppSelectedCampaignChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(campaign: event.campaign));
  }

  void _onSelectedTaskChanged(AppSelectedTaskChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(task: event.task));
  }

  void _onLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) {
    _setLocaleToSharedPrefs(event.locale);

    /// перезаписывает переменную sharedPrefsAppLocale новой локализацией, чтобы передать эту переменную в метод copyWith
    _getLocaleFromSharedPrefs();

    emit(state.copyWith(appLocale: sharedPrefsAppLocale ?? event.locale));
  }

  void _onSelectedNotificationChanged(
      AppSelectedNotificationChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(notification: event.notification));
  }

  void _setLocaleToSharedPrefs(AppLocales? appLocales) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String locale;
    switch (appLocales) {
      // case AppLocales.system:
      //   locale = 'system';
      //   break;
      case AppLocales.russian:
        locale = 'ru';
        break;
      case AppLocales.english:
        locale = 'en';
        break;
      case AppLocales.kyrgyz:
        locale = 'ky';
        break;
      default:
        return null;
    }
    sharedPreferences.setString('locale', locale);
    sharedPrefsAppLocale = appLocales;
  }

  void _getLocaleFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('locale')) {
      String sharedLang = sharedPreferences.getString('locale')!;
      switch (sharedLang) {
        // case 'system':
        //   sharedPrefsAppLocale = AppLocales.system;
        //   break;
        case 'ru':
          sharedPrefsAppLocale = AppLocales.russian;
          break;
        case 'en':
          sharedPrefsAppLocale = AppLocales.english;
          break;
        case 'ky':
          sharedPrefsAppLocale = AppLocales.kyrgyz;
      }
    }
  }
}
