part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class _AuthUserChanged extends AuthEvent {
  final User user;

  const _AuthUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLogoutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

class RequestAccountDeletion extends AuthEvent {
  @override
  List<Object> get props => [];
}

class DeleteAccount extends AuthEvent {
  const DeleteAccount();

  @override
  List<Object> get props => [];
}
