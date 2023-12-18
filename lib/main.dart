import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/app.dart';
import 'package:gigaturnip/src/utilities/notification_services.dart';
import 'package:gigaturnip/src/widgets/error_screen.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'src/bloc/bloc.dart';
import 'src/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  final dio = DioProvider.instance(authenticationRepository);
  final gigaTurnipApiClient = GigaTurnipApiClient(dio, baseUrl: AppConfig.apiUrl);
  final sharedPreferences = await SharedPreferences.getInstance();
  final router = AppRouter(authenticationRepository).router;
  NotificationServices notificationServices = NotificationServices();
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) => SliverToBoxAdapter(child: ErrorScreen(detailsException: flutterErrorDetails.exception));

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  try {
    messaging.onTokenRefresh.listen((fcmToken) {
      notificationServices.getDeviceToken(gigaTurnipApiClient, fcmToken);
    }).onError((err) {});
  } catch(e) {}

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
