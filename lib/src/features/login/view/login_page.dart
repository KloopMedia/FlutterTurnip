import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/login/widget/login_panel.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/login_bloc.dart';
import 'onboarding.dart';
import 'otp_verification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        sharedPreferences: context.read<SharedPreferences>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _phoneNumber = "";
  int? _resendToken;

  void loginWithPhone([int? forceResendToken]) async {
    final authenticationRepository = context.read<AuthenticationRepository>();
    final bloc = context.read<LoginBloc>();

    if (kIsWeb) {
      final result = await authenticationRepository.logInWithPhoneWeb(_phoneNumber);
      bloc.add(SendOTP(result.verificationId, null));
    } else {
      await authenticationRepository.logInWithPhone(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          bloc.add(CompleteVerification(credential));
        },
        verificationFailed: (FirebaseAuthException e) async {},
        codeSent: (String verificationId, int? resendToken) async {
          setState(() {
            _resendToken = resendToken;
          });
          bloc.add(SendOTP(verificationId, resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
        forceResendingToken: forceResendToken,
      );
    }
  }

  void _onChange(String phoneNumber) {
    setState(() {
      _phoneNumber = phoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    const radius = Radius.circular(15);

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed) {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return Dialog(
              //       child: Text(state.errorMessage),
              //     );
              //   },
              // );
            }
          },
          builder: (context, state) {
            // if (state is OTPCodeSend) {
            //   return VerificationPage(
            //     onResend: () => loginWithPhone(_resendToken),
            //     onConfirm: (smsCode) {
            //       context.read<LoginBloc>().add(ConfirmOTP(smsCode, state.verificationId));
            //     },
            //   );
            // }
            if (context.isSmall) {
              if (state is LoginInitial && state.firstTime) {
                return OnBoarding(
                  onContinue: () {
                    context.read<LoginBloc>().add(CloseOnBoarding());
                  },
                );
              } else if (state is OTPCodeSend) {
                return VerificationPage(
                  onResend: () => loginWithPhone(_resendToken),
                  onConfirm: (smsCode) {
                    context.read<LoginBloc>().add(ConfirmOTP(smsCode, state.verificationId));
                  },
                );
              }
              return LoginPanel(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 69),
                onChange: _onChange,
                onSubmit: loginWithPhone,
              );
            } else {
              return Row(
                children: [
                  Container(
                    width: context.isMedium
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: theme.primary,
                      borderRadius: const BorderRadius.only(topRight: radius, bottomRight: radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 30, right: 24/*45*/),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     color: Colors.grey,
                              //   ),
                              //   alignment: Alignment.center,
                              //   width: 70,
                              //   height: 70,
                              //   child: const Text('Logo'),
                              // ),
                              const SizedBox(height: 90),
                              const Text(
                                'Присоединяйтесь к сообществу проактивных людей!',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Здесь люди объединяются и решают общественно значимые проблемы вместе',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.85),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          (context.isSmall) ? Image.asset('assets/images/people.png') : Image.asset('assets/images/people_web.png'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (state is OTPCodeSend)
                           ? VerificationPage(
                            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 450),
                            onResend: () => loginWithPhone(_resendToken),
                            onConfirm: (smsCode) {
                            context.read<LoginBloc>().add(ConfirmOTP(smsCode, state.verificationId));
                            },
                          )
                           : Flexible(
                            child: LoginPanel(
                            padding: const EdgeInsets.all(20),
                            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
                            onChange: _onChange,
                            onSubmit: loginWithPhone,
                            ),
                          ),
                        // Flexible(
                        //   child: LoginPanel(
                        //     padding: const EdgeInsets.all(20),
                        //     constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
                        //     onChange: _onChange,
                        //     onSubmit: loginWithPhone,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}