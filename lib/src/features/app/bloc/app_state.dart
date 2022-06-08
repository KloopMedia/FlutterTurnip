part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppStateLoggedIn extends AppState {
  final AuthUser user;

  AppStateLoggedIn({required this.user});
}

class AppStateLoggedOut extends AppState with EquatableMixin {
  final Exception? exception;

  AppStateLoggedOut({required this.exception});

  @override
  List<Object?> get props => [exception];
}
