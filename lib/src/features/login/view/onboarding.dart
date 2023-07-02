import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/campaign/bloc/language_bloc/language_cubit.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/widgets.dart';
import 'language_picker.dart';

class OnBoarding extends StatefulWidget {
  final void Function() onContinue;
  final String? campaignName;
  final String? campaignDescription;
  final List<int?>? campaignLanguages;

  const OnBoarding({
    super.key,
    required this.onContinue,
    this.campaignName,
    this.campaignDescription,
    this.campaignLanguages,
  });
   @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String? errorMessage;
  bool isLocaleSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final state = context.watch<LocalizationBloc>().state;

    if (state.firstLogin == false) {
      setState(() {
        isLocaleSelected = !state.firstLogin;
      });
    }

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/people.png',
            width: 380,
            height: 281,
          ),
          (widget.campaignLanguages !=  null && widget.campaignLanguages!.isNotEmpty)
            ? BlocBuilder<LanguageCubit, RemoteDataState<Language>>(
              builder: (context, state) {
                if (state is RemoteDataLoaded<Language> && state.data.isNotEmpty) {
                  final data = state.data;
                  final List<SupportedLocale> campaignLocales = [];
                  for (var id in widget.campaignLanguages!) {
                    final matchedLanguage = data.where((e) => e.id == id).toList();
                    final locale = SupportedLocale(matchedLanguage.first.name, matchedLanguage.first.code);
                    campaignLocales.add(locale);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: LanguagePicker(
                      errorMessage: (errorMessage != null && isLocaleSelected == false)
                        ? errorMessage : null,
                      isLocaleSelected: isLocaleSelected,
                      campaignLocales: campaignLocales),
                  );
                }
                return const SizedBox.shrink();
              },
            )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: LanguagePicker(
                  errorMessage: (errorMessage != null && isLocaleSelected == false)
                    ? errorMessage
                    : null,
                  isLocaleSelected: isLocaleSelected,
                  campaignLocales: const [],
                ),
            ),
          Container(
            height: 200,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      (widget.campaignName != null) ? widget.campaignName! : context.loc.welcome_title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: theme.neutral30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      (widget.campaignDescription != null) ? widget.campaignDescription! : context.loc.welcome_subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: theme.neutral30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SignUpButton(
            onPressed: (message) {
              if (message != null) {
                setState(() {
                  errorMessage = message;
                });
              } else {
                widget.onContinue();
              }
            },
            isActive: isLocaleSelected,
          ),
        ],
      ),
    );
  }
}
