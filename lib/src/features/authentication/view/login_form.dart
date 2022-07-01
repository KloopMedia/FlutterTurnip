import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import "package:gigaturnip/extensions/buildcontext/loc.dart";

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppStateLoggedOut) {
          final exception = state.exception as LogInWithGoogleFailure?;
          if (exception != null) {
            showErrorDialog(context, exception.message);
          }
        }
      },
      child: const Align(
        alignment: Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Center(
            child: _GoogleLoginButton(),
          ),
        ),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: Text(
        context.loc.sign_in,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: theme.colorScheme.primary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<AppBloc>().add(AppLoginRequested()),
    );
  }
}
