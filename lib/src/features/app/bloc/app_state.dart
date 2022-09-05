part of 'app_bloc.dart';

enum AppLocales { system, russian, english, kyrgyz }

@immutable
class AppState extends Equatable {
  final AppLocales? appLocale;
  final AuthUser? user;
  final Campaign? selectedCampaign;
  final Task? selectedTask;
  final Notifications? selectedNotification;

  const AppState({
    this.appLocale,
    this.user,
    this.selectedCampaign,
    this.selectedTask,
    this.selectedNotification,
  });

  AppState copyWith({
    AppLocales? appLocale,
    AuthUser? user,
    Campaign? campaign,
    Task? task,
    Notifications? notification,
    Map<String, dynamic>? queryParameters,
  }) {
    return AppState(
      appLocale: appLocale ?? this.appLocale,
      user: user ?? this.user,
      selectedCampaign: campaign ?? selectedCampaign,
      selectedTask: task ?? selectedTask,
      selectedNotification: notification ?? selectedNotification,
    );
  }

  Locale? get locale {
    switch (appLocale) {
      case AppLocales.system:
        return null;
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

  @override
  List<Object?> get props =>
      [appLocale, user, selectedCampaign, selectedTask, selectedNotification];
}

class AppStateLoggedIn extends AppState {
  const AppStateLoggedIn({required user}) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AppStateLoggedOut extends AppState {
  final Exception? exception;

  const AppStateLoggedOut({required this.exception});

  @override
  List<Object?> get props => [exception];
}
