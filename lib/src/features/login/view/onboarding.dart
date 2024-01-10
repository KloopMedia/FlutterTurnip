import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/campaign_route.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart' as repo;
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../../campaign/bloc/country_bloc/country_cubit.dart';
import '../../campaign/bloc/language_bloc/language_cubit.dart';
import 'pickers.dart';

class OnBoarding extends StatelessWidget {
  final BoxConstraints? constraints;

  const OnBoarding({super.key, this.constraints});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: fontColor,
    );
    final subtitleTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: fontColor,
    );
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black
    );

    Future<void> redirect (BuildContext context, int campaignId) async {
      final campaign = await context.read<GigaTurnipApiClient>().getCampaignById(campaignId);
      final isJoined = campaign.isJoined;

      if (!context.mounted) return;

      if (isJoined) {
        context.pushNamed(
          TaskRoute.name,
          pathParameters: {'cid': '$campaignId'}
        );
      } else {
        await context.read<GigaTurnipApiClient>().joinCampaign(campaignId);
        if (!context.mounted) return;
        context.go(CampaignRoute.name);
      }
    }

    return Container(
      padding: (context.isSmall) ? const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0) : null,
      constraints: constraints,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (context.isSmall)
                IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                ),
              Text(
                context.loc.section_selection_title,
                style: titleTextStyle,
              ),
              Text(
                context.loc.section_selection,
                style: subtitleTextStyle,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    const campaignId = 7;
                    redirect(context, campaignId);
                  },
                  child: Container(
                    height: 217,
                    padding: const EdgeInsets.only(left:15, top: 14.5, right:15/*, bottom: 27.5*/),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EAFD),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(image: AssetImage('assets/images/english_image.png'), height: 126.5),
                        Text(context.loc.english_section, style: textStyle, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    const campaignId = 42;
                    redirect(context, campaignId);
                  },
                  child: Container(
                    height: 217,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFDF0E9),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    padding: const EdgeInsets.only(left:15, top: 8.5, right: 15/*, bottom: 27.5*/),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(image: AssetImage('assets/images/mobilography_image.png'), height: 126.5),
                        Text(context.loc.mobilography_section, style: textStyle, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                context.go(CampaignRoute.name);
              },
              child: Text(
                context.loc.skip,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: theme.primary
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class OnBoarding extends StatefulWidget {
//   final BoxConstraints? constraints;
//   final void Function(List value) onContinue;
//   final String title;
//   final String description;
//   final String? selectedCountry;
//   final List<int?>? campaignLanguages;
//   final List<int?>? campaignCountries;
//
//   const OnBoarding({
//     super.key,
//     required this.onContinue,
//     required this.title,
//     required this.description,
//     this.selectedCountry,
//     this.constraints,
//     this.campaignLanguages,
//     this.campaignCountries,
//   });
//    @override
//   State<OnBoarding> createState() => _OnBoardingState();
// }
//
// class _OnBoardingState extends State<OnBoarding> {
//   String? errorMessage;
//   List country = [];
//   bool secondPage = false;
//   bool isLocaleSelected = false;
//   bool isCountrySelected = false;
//   final Map<String, dynamic> countryMap = {};
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;
//     final state = context.watch<LocalizationBloc>().state;
//     final formKey = GlobalKey<FormState>();
//
//     if (state.firstLogin == false || widget.selectedCountry != null) {
//       setState(() {
//         isLocaleSelected = !state.firstLogin;
//       });
//     }
//
//     return Container(
//       constraints: widget.constraints,
//       padding: (context.isSmall) ? const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0) : null,
//       child: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: (secondPage) ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
//           children: [
//             if (context.isSmall && secondPage)
//               Padding(
//                 padding: const EdgeInsets.only(top: 24.0),
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios),
//                     onPressed: () {
//                       setState(() {
//                         secondPage = false;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             if (context.isSmall)
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   children: [
//                     (secondPage)
//                       ? Image.asset('assets/images/people_3.png', height: 300)
//                       : Image.asset('assets/images/earth.png', height: 300),
//                   ],
//                 ),
//               ),
//             if (context.isSmall && secondPage) const Spacer(),
//             Column(
//               crossAxisAlignment: (secondPage) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   (secondPage && context.isSmall) ? widget.title : context.loc.welcome,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600,
//                     color: fontColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   (secondPage && context.isSmall) ? widget.description : context.loc.choose_language_and_country,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: fontColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: (context.isSmall) ? 10 : 30),
//                 if (!secondPage)
//                   Column(
//                     children: [
//                       (widget.campaignLanguages !=  null && widget.campaignLanguages!.isNotEmpty)
//                         ? BlocBuilder<LanguageCubit, RemoteDataState<repo.Language>>(
//                           builder: (context, state) {
//                             if (state is RemoteDataLoaded<repo.Language> && state.data.isNotEmpty) {
//                               final data = state.data;
//                               final List<SupportedLocale> campaignLocales = [];
//                               for (var id in widget.campaignLanguages!) {
//                                 final matchedLanguage = data.where((e) => e.id == id).toList();
//                                 final locale = SupportedLocale(matchedLanguage.first.name, matchedLanguage.first.code);
//                                 campaignLocales.add(locale);
//                               }
//                               return LanguagePicker(
//                                 isLocaleSelected: isLocaleSelected,
//                                 campaignLocales: campaignLocales);
//                             }
//                             return const SizedBox.shrink();
//                           },
//                         )
//                         : LanguagePicker(
//                           isLocaleSelected: isLocaleSelected,
//                           campaignLocales: const [],
//                         ),
//                       SizedBox(height: (context.isSmall) ? 10 : 20),
//                       BlocBuilder<CountryCubit, RemoteDataState<repo.Country>>(
//                         builder: (context, state) {
//                           if (state is RemoteDataLoaded<repo.Country> && state.data.isNotEmpty) {
//                             final countries = state.data;
//                             if (widget.campaignCountries !=  null && widget.campaignCountries!.isNotEmpty) {
//                               for (var id in widget.campaignCountries!) {
//                                 final matchedCountry = countries.where((e) => e.id == id).toList();
//                                 final countryName = matchedCountry.first.name ?? '';
//                                 if (matchedCountry.isNotEmpty) {
//                                   isCountrySelected = true;
//                                   country = matchedCountry;
//                                 }
//                                 return CountryPicker(
//                                   campaignCountry: countryName,
//                                   countries: countries,
//                                   onTap: (value) {
//                                     setState(() {
//                                       isCountrySelected = true;
//                                       country = value;
//                                     });
//                                   },
//                                 );
//                               }
//                             } else {
//                               return CountryPicker(
//                                 campaignCountry: (country.isNotEmpty) ? '${country.first.name}' : null,
//                                 countries: countries,
//                                 onTap: (value) {
//                                   setState(() {
//                                     isCountrySelected = true;
//                                     country = value;
//                                   });
//                                 },
//                               );
//                             }
//                           }
//                           return const SizedBox.shrink();
//                         },
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             if (!context.isSmall) const SizedBox(height: 30),
//             if (secondPage) const SizedBox(height: 60),
//             (context.isSmall)
//               ? Row (
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   (secondPage)
//                     ? Row(
//                       children: [
//                         Container(
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: theme.neutral90
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         Container(
//                           width: 40,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: theme.primary
//                           ),
//                         ),
//                       ],
//                     )
//                     : Row(
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: theme.primary
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         Container(
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: theme.neutral90
//                           ),
//                         )
//                       ],
//                     ),
//                   SignUpButton(
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         if (!secondPage) {
//                           setState(() {
//                             secondPage = true;
//                           });
//                         } else {
//                           widget.onContinue(country);
//                         }
//                       }
//                     },
//                     buttonText: context.loc.further,
//                     isActive: isLocaleSelected && isCountrySelected,
//                   ),
//                 ],
//               )
//               : SignUpButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     widget.onContinue(country);
//                   }
//                 },
//                 buttonText: context.loc.further,
//                 width: double.infinity,
//                 isActive: isLocaleSelected && isCountrySelected,
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }
