import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/authentication/authentication.dart';
import 'package:gigaturnip/src/features/campaigns/view/campaigns_page.dart';
import 'package:gigaturnip/src/features/notifications/notifications.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/view/task_page.dart';
import 'package:gigaturnip/src/features/tasks/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            final bloc = context.read<AppBloc>();
            return MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: primaryColor,
                  secondary: secondaryColor,
                ),
                // fontFamily: 'Roboto',
                textTheme: ThemeData.light().textTheme.copyWith(
                  titleSmall: const TextStyle(
                    fontFamily: 'Open-Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                  ),
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
                )
              ),
              /// передается локализация, сохраненная в sharedPreferences
              locale: bloc.sharedPrefsLocale ?? state.locale ?? const Locale('system'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: state.user != null
                  ? const CampaignsPage()
                  : const LoginPage(),
              routes: {
                tasksRoute: (context) => const TasksPage(),
                createTasksRoute: (context) => const CreateTasksPage(),
                taskInstanceRoute: (context) => const TaskPage(),
                notificationsRoute: (context) => const NotificationsPage()
              },
            );
          },
        ),
      ),
    );
  }
}
