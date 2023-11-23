import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart' as repo;

import '../../../widgets/widgets.dart';
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
      padding: (context.isSmall) ? const EdgeInsets.all(24.0) : null,
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
                    (secondPage && context.isSmall) ? Image.asset('assets/images/people_3.png', width: 378, height: 365) : Image.asset('assets/images/earth.png'),
                  ],
                ),
              ),
              if (context.isSmall) const SizedBox(height: 60),
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
                        isLocaleSelected: isLocaleSelected,
                        campaignLocales: campaignLocales);
                  }
                  return const SizedBox.shrink();
                },
               )
               : LanguagePicker(
                 isLocaleSelected: isLocaleSelected,
                 campaignLocales: const [],
               ),
              if (!secondPage) const SizedBox(height: 20),
              if (!secondPage)
                BlocBuilder<CountryCubit, RemoteDataState<repo.Country>>(
                  builder: (context, state) {
                    if (state is RemoteDataLoaded<repo.Country> && state.data.isNotEmpty) {
                      final countries = state.data;
                      if (widget.campaignCountries !=  null && widget.campaignCountries!.isNotEmpty) {
                        for (var id in widget.campaignCountries!) {
                          final matchedCountry = countries.where((e) => e.id == id).toList();
                          final countryName = matchedCountry.first.name ?? '';
                          if (matchedCountry.isNotEmpty) {
                            isCountrySelected = true;
                            country = matchedCountry;
                          }
                          return CountryPicker(
                            campaignCountry: countryName,
                            countries: countries,
                            onTap: (value) {
                              setState(() {
                                isCountrySelected = true;
                                country = value;
                              });
                            },
                          );
                        }
                      } else {
                        return CountryPicker(
                          campaignCountry: (country.isNotEmpty) ? '${country.first.name}' : null,
                          countries: countries,
                          onTap: (value) {
                            setState(() {
                              isCountrySelected = true;
                              country = value;
                            });
                          },
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              const SizedBox(height: 60),
              (context.isSmall)
                ? Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (secondPage && context.isSmall) //? Image.asset('assets/images/indicator_2.png') : Image.asset('assets/images/indicator_1.png'),
                    ? Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 40,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue
                          ),
                        ),
                      ],
                    )
                    : Row(
                    children: [
                      Container(
                        width: 40,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey
                        ),
                      )
                    ],
                  ),
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
                    isActive: isLocaleSelected && isCountrySelected,
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
                isActive: isLocaleSelected && isCountrySelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
