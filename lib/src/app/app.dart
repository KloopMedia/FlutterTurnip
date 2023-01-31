import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required GigaTurnipRepository gigaTurnipRepository,
  })
      : _authenticationRepository = authenticationRepository,
        _gigaTurnipRepository = gigaTurnipRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final GigaTurnipRepository _gigaTurnipRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        ),
        RepositoryProvider<GigaTurnipRepository>(
          create: (context) => _gigaTurnipRepository,
        ),
      ],
      child: BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(
                authenticationRepository: _authenticationRepository,
              ),
          child: BlocBuilder(
            builder: (context, state) {
              throw UnimplementedError();
            },
          ),
      ),
    );
  }
}
