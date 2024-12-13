import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/bloc.dart';
import '../bloc/login_bloc.dart';
import '../widget/login_panel.dart'; // Adjust import based on actual path
import 'onboarding.dart';
import 'otp_verification.dart';

/// The main login view, showing login panel, onboarding, or OTP verification depending on the [LoginBloc] state.
class LoginView extends StatefulWidget {
  final int? campaignId;

  const LoginView({super.key, this.campaignId});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late SharedPreferences sharedPreferences;
  String _phoneNumber = "";
  String? errorMessage;
  bool isLocaleSelected = false;
  int? _resendToken;

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

  void _loginWithPhone([int? forceResendToken]) async {
    final authenticationRepository = context.read<AuthenticationRepository>();
    final bloc = context.read<LoginBloc>();

    if (kIsWeb) {
      // Web login
      final result = await authenticationRepository.logInWithPhoneWeb(_phoneNumber);
      bloc.add(SendOTP(result.verificationId, null));
    } else {
      // Mobile login
      await authenticationRepository.logInWithPhone(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) => bloc.add(CompleteVerification(credential)),
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _resendToken = resendToken;
          });
          bloc.add(SendOTP(verificationId, resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: forceResendToken,
      );
    }
  }

  void _onPhoneNumberChanged(String phoneNumber) {
    setState(() {
      _phoneNumber = phoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      color: theme.surface,
      child: SafeArea(
        child: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!context.isSmall) _buildSideImage(context),
              _buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSideImage(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final width = context.isMedium
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width / 3;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 30, right: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/people_3.png', height: 330),
              const SizedBox(height: 20),
              Text(
                context.loc.welcome_title,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                context.loc.welcome_subtitle,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.85),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        if (loginState is LoginSuccess) {
          return Flexible(
            child: OnBoarding(
              constraints: context.isSmall ? null : const BoxConstraints(maxWidth: 650, maxHeight: 430),
            ),
          );
        } else if (loginState is LoginInitial) {
          return Expanded(
            child: LoginPanel(
              constraints: kIsWeb ? const BoxConstraints(maxWidth: 600, maxHeight: 460) : null,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              onChange: _onPhoneNumberChanged,
              onSubmit: (value) {
                if (value != null) {
                  setState(() => errorMessage = value);
                } else {
                  _loginWithPhone();
                }
              },
              isLocaleSelected: isLocaleSelected,
              errorMessage: errorMessage,
            ),
          );
        } else if (loginState is OTPCodeSend) {
          return VerificationPage(
            constraints: kIsWeb ? const BoxConstraints(maxWidth: 600, maxHeight: 450) : null,
            onResend: () => _loginWithPhone(_resendToken),
            onConfirm: (smsCode) {
              context.read<LoginBloc>().add(ConfirmOTP(smsCode, loginState.verificationId));
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}