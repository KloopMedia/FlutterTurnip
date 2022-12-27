import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import "package:gigaturnip/extensions/buildcontext/loc.dart";

class LoginForm extends StatelessWidget {
  final bool simpleViewMode;
  const LoginForm({Key? key, required this.simpleViewMode}) : super(key: key);

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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _GoogleLoginButton(),
            const SizedBox(height: 10),
            if (simpleViewMode) const _AppleLoginButton(),
          ],
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
        context.loc.sign_in_with_google,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<AppBloc>().add(const AppLoginRequested(LoginProvider.google)),
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  const _AppleLoginButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_appleLogin_raisedButton'),
      label: Text(
        context.loc.sign_in_with_apple,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      icon: const Icon(FontAwesomeIcons.apple, color: Colors.white),
      onPressed: () => context.read<AppBloc>().add(const AppLoginRequested(LoginProvider.apple)),
    );
  }
}
