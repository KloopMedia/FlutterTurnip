import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final gigaTurnipRepository = GigaTurnipRepository();
  await SharedPreferences.getInstance();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskStageAdapter());
  Hive.registerAdapter(ChainAdapter());
  await Hive.initFlutter();

  if (!kIsWeb) {
    await Permission.microphone.request();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      gigaTurnipRepository: gigaTurnipRepository,
    ),
  );
}
