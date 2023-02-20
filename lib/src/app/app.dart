import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/app/routes/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gigaturnip/src/bloc/localization_bloc/localization_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(_authenticationRepository).router;
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      // theme: web_theme,
      locale: context.watch<LocalizationBloc>().state.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
