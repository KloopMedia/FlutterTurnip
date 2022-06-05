import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/services/auth/auth_exceptions.dart';
import 'package:gigaturnip/services/auth/bloc/auth_bloc.dart';
import 'package:gigaturnip/services/auth/bloc/auth_event.dart';
import 'package:gigaturnip/services/auth/bloc/auth_state.dart';
import 'package:gigaturnip/utilities/dialogs/show_error_dialog.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          if (state.exception is GenericAuthException) {
            showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(const AuthEventLogIn());
            },
            child: const Text('Log in'),
          ),
        ),
      ),
    );
  }
}
