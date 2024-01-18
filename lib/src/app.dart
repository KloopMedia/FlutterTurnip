import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gigaturnip/src/bloc/localization_bloc/localization_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:gigaturnip/src/utilities/notification_services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/theme_bloc/theme_cubit.dart';

class App extends StatefulWidget {
  final GoRouter router;

  const App({Key? key, required this.router}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    notificationServices.initialize(widget.router);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: widget.router.routeInformationProvider,
      routeInformationParser: widget.router.routeInformationParser,
      routerDelegate: widget.router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xFF5E81FB)),
        ),
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      darkTheme: ThemeData(
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xFF9BB1FF)),
        ),
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      themeMode: context.watch<ThemeCubit>().state.themeMode,
      locale: context.watch<LocalizationBloc>().state.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaler: const TextScaler.linear(0.9)),
          child: child!,
        );
      },
    );
  }
}
