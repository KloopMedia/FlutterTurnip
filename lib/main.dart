import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/constants/routes.dart';
import 'package:gigaturnip/services/auth/bloc/auth_bloc.dart';
import 'package:gigaturnip/services/auth/bloc/auth_event.dart';
import 'package:gigaturnip/services/auth/bloc/auth_state.dart';
import 'package:gigaturnip/services/auth/google_sign_in_auth_provider.dart';
import 'package:gigaturnip/utilities/dialogs/show_error_dialog.dart';

import 'views/campaigns_view.dart';
import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(GoogleSignInAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      loginRoute: (context) => const LoginView(),
      campaignsRoute: (context) => const CampaignsView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          // TODO: Add loading screen
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const CampaignsView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
