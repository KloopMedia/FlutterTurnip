import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/login/widget/language_picker.dart';
import 'package:gigaturnip/src/features/login/widget/provider_buttons.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/bloc.dart';
import '../widget/privacy_policy.dart';

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
    setState(() {
      isLocaleSelected = state.firstLogin == false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildLogoSection(),
              SizedBox(height: 16),
              Expanded(child: _buildLoginPanel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFEFBD2), Color(0xFFFECFB5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }

  Widget _buildLogoSection() {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: 45),
        SizedBox(
          height: context.isSmall ? 304 : screenHeight / 3,
          child: Placeholder(), // Replace with your logo widget
        ),
      ],
    );
  }

  Widget _buildLoginPanel() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
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
            _buildLoginContent(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginContent() {
    return SizedBox(
      width: 334,
      child: Column(
        children: [
          Text(
            context.loc.login_header,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: theme.neutral30, height: 1.17),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Text(
            context.loc.login_description,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: theme.neutral30, height: 1.17),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          LanguagePicker(isLocaleSelected: isLocaleSelected),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: LoginProviderButtons(
            isActive: true,
            onError: (value) {
              setState(() {
                errorMessage = value;
              });
            },
          ),
        ),
        const SizedBox(height: 32),
        const PrivacyPolicy(),
      ],
    );
  }
}
