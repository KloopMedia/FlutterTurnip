import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final dio = DioProvider.instance(authenticationRepository);
  final gigaTurnipApiClient = GigaTurnipApiClient(dio);
  final gigaTurnipRepository = GigaTurnipRepository(gigaTurnipApiClient);
  await SharedPreferences.getInstance();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      gigaTurnipRepository: gigaTurnipRepository,
    ),
  );
}
