import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/bloc/localization_bloc/localization_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:go_router/go_router.dart';

import 'bloc/theme_bloc/theme_cubit.dart';

class App extends StatelessWidget {
  final GoRouter router;

  const App({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final deviceSize = MediaQuery.of(context).size;
        return ScreenUtilInit(
          designSize: deviceSize,
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp.router(
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: context.watch<ThemeCubit>().state.themeMode,
              locale: context.watch<LocalizationBloc>().state.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            );
          },
        );
      },
    );
  }
}
