part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  final AuthUser user;

  @visibleForTesting
  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class AppSelectedCampaignChange extends AppEvent {
  final Campaign? campaign;

  const AppSelectedCampaignChange(this.campaign);
}