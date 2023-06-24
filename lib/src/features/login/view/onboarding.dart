import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../widgets/widgets.dart';
import 'language_picker.dart';

class OnBoarding extends StatefulWidget {
  final void Function() onContinue;

  const OnBoarding({super.key, required this.onContinue});
   @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String? errorMessage;
  bool isLocaleSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocConsumer<LocalizationBloc, LocalizationState>(
      listener: (context, state) {
        if (state.firstLogin == false) {
          isLocaleSelected = !state.firstLogin;
          errorMessage = null;
          print('>>> listener = ${state.firstLogin} / $errorMessage');
        }
      },
      builder: (context, state) {
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
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: LanguagePicker(errorMessage: errorMessage)
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          /*(byLink) ? campaign.name :*/ context.loc.welcome_title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: theme.neutral30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          /*(byLink) ? campaign.description :*/ context.loc.welcome_subtitle,
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
                    print('>>> continue 2');
                    widget.onContinue();
                  }
                },
                isActive: isLocaleSelected,
              ),
            ],
          ),
        );
      }
    );
  }
}
