part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppLoginRequested extends AppEvent {}

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
