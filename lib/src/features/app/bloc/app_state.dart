part of 'app_bloc.dart';

@immutable
class AppState extends Equatable {
  final AuthUser? user;
  final Campaign? selectedCampaign;
  final Task? selectedTask;

  const AppState({this.user, this.selectedCampaign, this.selectedTask});

  AppState copyWith({AuthUser? user, Campaign? campaign, Task? task}) {
    return AppState(
      user: user ?? this.user,
      selectedCampaign: campaign ?? selectedCampaign,
      selectedTask: task ?? selectedTask,
    );
  }

  @override
  List<Object?> get props => [user, selectedCampaign, selectedTask];
}

class AppStateLoggedIn extends AppState {
  const AppStateLoggedIn({required user}) : super(user: user);
}

class AppStateLoggedOut extends AppState {
  final Exception? exception;

  const AppStateLoggedOut({required this.exception});

  @override
  List<Object?> get props => [exception];
}
