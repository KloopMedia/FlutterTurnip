import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // final router = AppRouter(_authenticationRepository).router;
    // return MaterialApp.router(
    //   routeInformationProvider: router.routeInformationProvider,
    //   routeInformationParser: router.routeInformationParser,
    //   routerDelegate: router.routerDelegate,
    //   debugShowCheckedModeBanner: false,
    //   theme: web_theme,
    //   locale: bloc.sharedPrefsLocale ?? bloc.state.locale ?? const Locale('ky'),
    //   supportedLocales: AppLocalizations.supportedLocales,
    //   localizationsDelegates: AppLocalizations.localizationsDelegates,
    // );
  }
}
