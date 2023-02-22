import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/app/routes/app_router.dart';
import 'package:gigaturnip/src/features/app/theme/app_theme.dart';
import 'package:gigaturnip/src/features/app/theme/ombudsman_theme.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../theme/ombudsman_theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required GigaTurnipRepository gigaTurnipRepository,
  })  : _authenticationRepository = authenticationRepository,
        _gigaTurnipRepository = gigaTurnipRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final GigaTurnipRepository _gigaTurnipRepository;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(_authenticationRepository).router;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => _authenticationRepository),
        RepositoryProvider<GigaTurnipRepository>(
          create: ((context) => _gigaTurnipRepository),
        )
      ],
      child: BlocProvider<AppBloc>(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
          gigaTurnipRepository: _gigaTurnipRepository,
        ),
        child: BlocConsumer<AppBloc, AppState>(listener: (context, state) {
          if (!kIsWeb) {
            FirebaseCrashlytics.instance.setUserIdentifier('${state.user?.id}');
            FirebaseCrashlytics.instance.setCustomKey(
                'campaign', '[${state.selectedCampaign?.id}] ${state.selectedCampaign?.name}');
            FirebaseCrashlytics.instance
                .setCustomKey('task', '[${state.selectedTask?.id}] ${state.selectedTask?.name}');
          }
        }, builder: (context, state) {
          final bloc = context.read<AppBloc>();

          return MaterialApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            debugShowCheckedModeBanner: false,
            theme: web_theme,
            locale: bloc.sharedPrefsLocale ?? bloc.state.locale ?? const Locale('ky'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          );
        }),
      ),
    );
  }
}
