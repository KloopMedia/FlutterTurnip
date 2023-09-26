import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart' as repo;

import '../../../widgets/widgets.dart';
import '../../campaign/bloc/campaign_cubit.dart';
import '../../campaign/bloc/country_bloc/country_cubit.dart';
import '../../campaign/bloc/language_bloc/language_cubit.dart';
import 'pickers.dart';

class OnBoarding extends StatefulWidget {
  final BoxConstraints? constraints;
  final void Function(List value) onContinue;
  final String title;
  final String description;
  final String? selectedCountry;
  final List<int?>? campaignLanguages;
  final List<int?>? campaignCountries;

  const OnBoarding({
    super.key,
    required this.onContinue,
    required this.title,
    required this.description,
    this.selectedCountry,
    this.constraints,
    this.campaignLanguages,
    this.campaignCountries,
  });
   @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String? errorMessage;
  List country = [];
  bool secondPage = false;
  bool isLocaleSelected = false;
  bool isCountrySelected = false;
  final Map<String, dynamic> countryMap = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;
    final state = context.watch<LocalizationBloc>().state;
    final formKey = GlobalKey<FormState>();

    if (state.firstLogin == false || widget.selectedCountry != null) {
      setState(() {
        isLocaleSelected = !state.firstLogin;
      });
    }

    return Container(
      constraints: widget.constraints,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: (secondPage && context.isSmall) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              if (secondPage && context.isSmall)
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        secondPage = false;
                      });
                    },
                  ),
                ),
              if (context.isSmall)
                Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    (secondPage && context.isSmall) ? Image.asset('assets/images/people_2.png') : Image.asset('assets/images/group.png'),
                    Container(height: 1, color: const Color(0xFFB8B8AE))
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Text(
                (secondPage && context.isSmall) ? widget.title : context.loc.welcome,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                (secondPage && context.isSmall) ? widget.description : context.loc.choose_language_and_country,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: fontColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (!secondPage) const SizedBox(height: 20),
              if (!secondPage)
                (widget.campaignLanguages !=  null && widget.campaignLanguages!.isNotEmpty)
                ? BlocBuilder<LanguageCubit, RemoteDataState<repo.Language>>(
                builder: (context, state) {
                  if (state is RemoteDataLoaded<repo.Language> && state.data.isNotEmpty) {
                    final data = state.data;
                    final List<SupportedLocale> campaignLocales = [];
                    for (var id in widget.campaignLanguages!) {
                      final matchedLanguage = data.where((e) => e.id == id).toList();
                      final locale = SupportedLocale(matchedLanguage.first.name, matchedLanguage.first.code);
                      campaignLocales.add(locale);
                    }
                    return LanguagePicker(
                        errorMessage: (errorMessage != null && isLocaleSelected == false)
                            ? errorMessage : 'null',
                        isLocaleSelected: isLocaleSelected,
                        campaignLocales: campaignLocales);
                  }
                  return const SizedBox.shrink();
                },
               )
               : LanguagePicker(
                 errorMessage: (errorMessage != null && isLocaleSelected == false)
                     ? errorMessage
                     : null,
                 isLocaleSelected: isLocaleSelected,
                 campaignLocales: const [],
               ),
              if (!secondPage) const SizedBox(height: 20),
              // BlocBuilder<LanguageCubit, RemoteDataState<repo.Language>>(
              //     builder: (context, state) {
              //         if (state is RemoteDataLoaded<repo.Language> && state.data.isNotEmpty) {
              //         final countries = state.data;
              //         final List<String> campaignCountries = [];
              //         // if (widget.campaignCountries !=  null && widget.campaignCountries!.isNotEmpty) {
              //         //   for (var id in widget.campaignLanguages!) {
              //         //     final matchedCountry = countries.where((e) => e.id == id).toList();
              //         //     countryname = matchedCountry.first.name;
              //         //   }
              //         // }
              //           return CountryPicker(
              //             campaignCountry: widget.selectedCountry,
              //             countries: countries,
              //             onTap: (value) {
              //               // campaignCountries.removeWhere((item) => item == country);
              //               // campaignCountries.add(country);
              //               // countryMap.addAll({'countries__name': country});
              //               setState(() {
              //                 isCountrySelected = true;
              //                 country = value;
              //               });
              //             },
              //           );
              //       }
              //       return const SizedBox.shrink();
              //     },
              //   ),
              const SizedBox(height: 60),
              (context.isSmall)
                ? Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (secondPage && context.isSmall) ? Image.asset('assets/images/indicator_2.png') : Image.asset('assets/images/indicator_1.png'),
                  SignUpButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (!secondPage) {
                          setState(() {
                            secondPage = true;
                          });
                        } else {
                          widget.onContinue(country);
                        }
                      }
                    },
                    buttonText: context.loc.further,
                    isActive: isLocaleSelected,// && isCountrySelected,
                  ),
                ],
              )
              : SignUpButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.onContinue(country);
                  }
                },
                buttonText: context.loc.further,
                width: double.infinity,
                isActive: isLocaleSelected,// && isCountrySelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
