import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/authentication/authentication.dart';
import 'package:gigaturnip/src/features/campaigns/view/campaigns_page.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/view/task_page.dart';
import 'package:gigaturnip/src/features/tasks/index.dart';
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
        child: MaterialApp(
    theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.grey,
            buttonColor: Colors.red,
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black,
                fontFamily:'OpenSans',
                fontWeight:FontWeight.bold,
                fontSize: 18,
              ),
            ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
                button: TextStyle(
                  color: Colors.white,
                )
              ),
            ),
          ),
          home: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state.user != null) {
                return const CampaignsPage();
              }
              else {
                return const LoginPage();
              }
            },
          ),
          routes: {
            tasksRoute: (context) => const TasksPage(),
            createTasksRoute: (context) => const CreateTasksPage(),
            taskInstanceRoute: (context) => const TaskPage(),
          },
        ),
      ),
    );
  }
}