import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import '../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _GoogleLoginButton(),
              SizedBox(height: 10),
              _AppleLoginButton(),
            ],
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
      icon: const Icon(Icons.g_mobiledata, color: Colors.white),
      onPressed: () => context.read<LoginBloc>().add(const TryToLogin(AuthProvider.google)),
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  const _AppleLoginButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
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
      icon: const Icon(Icons.apple, color: Colors.white),
      onPressed: () => context.read<LoginBloc>().add(const TryToLogin(AuthProvider.google)),
    );
  }
}
