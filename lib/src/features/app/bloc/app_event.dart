part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class DeleteAccountRequested extends AppEvent {}

enum LoginProvider {apple, google}

class AppLoginRequested extends AppEvent {
  final LoginProvider provider;

  const AppLoginRequested(this.provider);
}

class AppUserChanged extends AppEvent {
  final AuthUser user;

  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class AppLocaleChanged extends AppEvent {
  final AppLocales locale;

  const AppLocaleChanged(this.locale);
}

class AppSelectedCampaignChanged extends AppEvent {
  final Campaign? campaign;

  const AppSelectedCampaignChanged(this.campaign);
}

class AppSelectedTaskChanged extends AppEvent {
  final Task? task;

  const AppSelectedTaskChanged(this.task);
}

class AppSelectedNotificationChanged extends AppEvent {
  final Notifications? notification;

  const AppSelectedNotificationChanged(this.notification);
}
