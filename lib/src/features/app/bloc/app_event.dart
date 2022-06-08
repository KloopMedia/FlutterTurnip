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

  @visibleForTesting
  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}