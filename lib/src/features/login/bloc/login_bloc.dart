import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<TryToLogin>(_onTryToLogin);
  }

  Future<void> _login(AuthProvider provider) async {
    switch (provider) {
      case AuthProvider.google:
        await _authenticationRepository.logInWithGoogle();
        break;
      case AuthProvider.apple:
        await _authenticationRepository.logInWithApple();
        break;
      case AuthProvider.phone:
        // TODO: Handle this case.
        break;
    }
  }

  void _onTryToLogin(TryToLogin event, Emitter<LoginState> emit) {
    final provider = event.provider;

    try {
      _login(provider);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
