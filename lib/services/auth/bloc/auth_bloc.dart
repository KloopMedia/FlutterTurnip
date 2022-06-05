import 'package:bloc/bloc.dart';
import 'package:gigaturnip/services/api/api_provider.dart';
import 'package:gigaturnip/services/auth/auth_provider.dart';
import 'package:gigaturnip/services/auth/bloc/auth_event.dart';
import 'package:gigaturnip/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // initialize
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } else {
        ApiProvider api = ApiProvider(provider: provider);
        var campaigns = await api.getCampaigns();
        emit(AuthStateLoggedIn(user: user, isLoading: false, campaigns: campaigns));
      }
    });

    // log in
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait while I log you in',
      ));
      try {
        final user = await provider.logIn();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    // log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
