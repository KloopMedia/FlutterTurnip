import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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
import 'package:go_router/go_router.dart';

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

    final GoRouter router = GoRouter(
      redirect: (routeState) {
        final bool loggedIn = _authenticationRepository.currentUser.isNotEmpty;
        final bool loggingIn = routeState.subloc == '/login';
        if (!loggedIn) {
          return loggingIn ? null : '/login';
        }

        // if the user is logged in but still on the login page, send them to
        // the home page
        if (loggingIn) {
          return '/';
        }

        // no need to redirect at all
        return null;
      },
      routes: <GoRoute>[
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: 'campaign',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
            return CampaignsPage(
              simpleViewMode: simpleViewMode,
            );
          },
          routes: [
            GoRoute(
              name: 'tasks',
              path: 'campaign/:cid',
              builder: (BuildContext context, GoRouterState state) {
                final id = state.params['cid'];
                final simpleViewMode = state.queryParams['simple']?.toLowerCase() == 'true';
                if (id != null) {
                  return TasksPage(
                    campaignId: int.parse(id),
                    simpleViewMode: simpleViewMode,
                  );
                }
                return const TasksPage();
              },
              routes: [
                GoRoute(
                  name: 'createTasks',
                  path: 'new-task',
                  builder: (BuildContext context, GoRouterState state) {
                    return const CreateTasksPage();
                  },
                ),
                GoRoute(
                  name: 'taskInstance',
                  path: 'tasks/:tid',
                  builder: (BuildContext context, GoRouterState state) {
                    final id = state.params['tid'];
                    if (id != null) {
                      return TaskPage(
                        taskId: int.parse(id),
                      );
                    }
                    return const TaskPage();
                  },
                ),
                GoRoute(
                  name: 'notifications',
                  path: 'notifications',
                  builder: (BuildContext context, GoRouterState state) {
                    return const NotificationsPage();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );

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
        child: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (!kIsWeb) {
              FirebaseCrashlytics.instance.setUserIdentifier('${state.user?.id}');
              FirebaseCrashlytics.instance.setCustomKey(
                  'campaign', '[${state.selectedCampaign?.id}] ${state.selectedCampaign?.name}');
              FirebaseCrashlytics.instance
                  .setCustomKey('task', '[${state.selectedTask?.id}] ${state.selectedTask?.name}');
            }
          },
          child: Builder(builder: (context) {
            final bloc = context.read<AppBloc>();
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
      ),
    );
  }
}
