import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/app.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'src/bloc/bloc.dart';
import 'src/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  final dio = DioProvider.instance(authenticationRepository);
  final gigaTurnipApiClient = GigaTurnipApiClient(dio, baseUrl: AppConfig.apiUrl);
  final sharedPreferences = await SharedPreferences.getInstance();
  final router = AppRouter(authenticationRepository).router;

  if (!kIsWeb) {
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await FlutterDownloader.initialize(
        debug: true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
        );
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
          BlocProvider(
            create: (_) => ThemeCubit(sharedPreferences: sharedPreferences),
          )
        ],
        child: App(router: router),
      ),
    ),
  );
}
