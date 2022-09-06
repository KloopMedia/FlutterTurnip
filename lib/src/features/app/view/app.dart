import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/app/routes/app_router.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

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
    const Color primaryColor = Color.fromRGBO(69, 123, 157, 1);
    const Color secondaryColor = Color.fromRGBO(168, 210, 219, 1);

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
          final router = AppRouter(context, state).router;

          return MaterialApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: primaryColor,
                  secondary: secondaryColor,
                ),
                // fontFamily: 'Roboto',
                textTheme: ThemeData.light().textTheme.copyWith(
                      titleSmall: const TextStyle(
                          fontFamily: 'Open-Sans', fontWeight: FontWeight.w400, fontSize: 18),
                      titleMedium: const TextStyle(
                        fontFamily: 'Open-Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                      titleLarge: const TextStyle(
                        fontFamily: 'Open-Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 27,
                        color: Colors.white,
                      ),
                      headlineLarge: const TextStyle(
                        fontFamily: 'Open-Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 23,
                        color: Colors.black87,
                      ),
                      headlineMedium: const TextStyle(
                        fontFamily: 'Open-Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      headlineSmall: const TextStyle(
                        fontFamily: 'Open-Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                appBarTheme: const AppBarTheme(
                  color: primaryColor,
                )),

            /// передается локализация, сохраненная в sharedPreferences
            locale: bloc.sharedPrefsLocale ?? bloc.state.locale ?? const Locale('system'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          );
        }),
      ),
    );
  }
}
