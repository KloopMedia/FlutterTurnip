import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/app.dart';
import 'package:gigaturnip/src/widgets/error_screen.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'src/bloc/bloc.dart';
import 'src/router/router.dart';
import 'src/router/routes/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  final dio = DioProvider.instance(authenticationRepository);
  final gigaTurnipApiClient = GigaTurnipApiClient(dio, baseUrl: AppConfig.apiUrl);
  final sharedPreferences = await SharedPreferences.getInstance();
  final router = AppRouter(authenticationRepository).router;
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) => SliverToBoxAdapter(child: ErrorScreen(detailsException: flutterErrorDetails.exception));

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
        NotificationDetailRoute.name,
        arguments: message
    );
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final token = await messaging.getToken();
  await gigaTurnipApiClient.updateFcmToken({'fcm_token': token});

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  /// handle notification if the app was terminated and now opened
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  /// attach event listeners for when a notification opens the app
  FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<GigaTurnipApiClient>(
          create: (context) => gigaTurnipApiClient,
        ),
        RepositoryProvider<SharedPreferences>(
          create: (context) => sharedPreferences,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authenticationRepository: authenticationRepository,
              gigaTurnipApiClient: gigaTurnipApiClient,
            ),
          ),
          BlocProvider(
            create: (_) => LocalizationBloc(sharedPreferences: sharedPreferences, /*showSavedLocale: true*/),
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
