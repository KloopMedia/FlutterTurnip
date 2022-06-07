part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final AuthUser user;
  final Campaign? selectedCampaign;

  const AppState._({
    required this.status,
    this.user = AuthUser.empty,
    this.selectedCampaign
  });

  const AppState.authenticated(AuthUser user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  AppState copyWith({
    AppStatus? status,
    AuthUser? user,
    Campaign? selectedCampaign,
  }) {
    return AppState._(
        status: status ?? this.status,
        user: user ?? this.user,
        selectedCampaign: selectedCampaign ?? this.selectedCampaign
    );
  }

  @override
  List<Object> get props => [status, user];
}