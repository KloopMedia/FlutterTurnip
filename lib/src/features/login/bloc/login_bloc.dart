import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<TryToLogin>(_onTryToLogin);
  }

  void _onTryToLogin(TryToLogin event, Emitter<LoginState> emit) {

  }
}
