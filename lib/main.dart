import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/app/app.dart';
import 'package:gigaturnip/src/bloc/localization_bloc/localization_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'src/bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  final dio = DioProvider.instance(authenticationRepository);
  final gigaTurnipApiClient = GigaTurnipApiClient(dio, baseUrl: AppConfig.apiUrl);
  final sharedPreferences = await SharedPreferences.getInstance();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<GigaTurnipApiClient>(
          create: (context) => gigaTurnipApiClient,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(authenticationRepository: authenticationRepository),
          ),
          BlocProvider(
            create: (_) => LocalizationBloc(sharedPreferences: sharedPreferences),
          ),
          // TODO: Add blocs for localization, theme
        ],
        child: const App(),
      ),
    ),
  );
}
