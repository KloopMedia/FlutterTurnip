import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/app.dart';
import 'package:gigaturnip/src/features/login/widget/language_picker.dart';
import 'package:gigaturnip/src/features/login/widget/provider_buttons.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/bloc.dart';
import '../bloc/login_bloc.dart';
import '../widget/privacy_policy.dart';

/// The main login view, showing login panel, onboarding, or OTP verification depending on the [LoginBloc] state.
class LoginView extends StatefulWidget {
  final int? campaignId;

  const LoginView({super.key, this.campaignId});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late SharedPreferences sharedPreferences;
  late final theme = Theme.of(context).colorScheme;
  String? errorMessage;
  bool isLocaleSelected = false;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    final state = context.read<LocalizationBloc>().state;
    if (state.firstLogin == false) {
      setState(() {
        isLocaleSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFEFBD2), Color(0xFFFECFB5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  SizedBox(height: 29),
                  SizedBox(
                    height: 315,
                    width: 285,
                    child: Placeholder(),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 334,
                          child: Column(
                            children: [
                              Text(
                                'Учись легко и эффективно!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 14),
                              Text(
                                'Зарегистрируйтесь, чтобы получить доступ к бесплатным курсам',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: theme.neutral30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 21),
                              LanguagePicker(isLocaleSelected: isLocaleSelected)
                            ],
                          ),
                        ),
                        // SizedBox(height: 51),
                        Column(
                          children: [
                            LoginProviderButtons(
                              isActive: true,
                              onError: (value) {},
                            ),
                            SizedBox(height: 40),
                            PrivacyPolicy(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
