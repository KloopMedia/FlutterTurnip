import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:gigaturnip/firebase_options.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      final gigaTurnipRepository = GigaTurnipRepository();
      runApp(
        App(
          authenticationRepository: authenticationRepository,
          gigaTurnipRepository: gigaTurnipRepository,
        ),
      );
    },
  );
}
