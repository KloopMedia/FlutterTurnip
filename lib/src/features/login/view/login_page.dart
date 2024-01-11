import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/login/widget/login_panel.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/bloc.dart';
import '../../campaign/bloc/country_bloc/country_cubit.dart';
import '../../campaign/bloc/language_bloc/language_cubit.dart';
import '../../campaign_detail/bloc/campaign_detail_bloc.dart';
import '../bloc/login_bloc.dart';
import 'onboarding.dart';
import 'otp_verification.dart';

class LoginPage extends StatelessWidget {
  final int? campaignId;

  const LoginPage({Key? key, this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(
            sharedPreferences: context.read<SharedPreferences>(),
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
        if (campaignId != null) BlocProvider(
          create: (context) => CampaignDetailBloc(
            repository: CampaignDetailRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            ),
            campaignId: campaignId!,
          )..add(InitializeCampaign()),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(
            LanguageRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CountryCubit(
            CountryRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            ),
            context.read<GigaTurnipApiClient>(),
          )..initialize(),
        ),
      ],
      child: LoginView(campaignId: campaignId),
    );
  }
}

class LoginView extends StatefulWidget {
  final int? campaignId;

  const LoginView({Key? key, this.campaignId}) : super(key: key);

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
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

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

    final state = context.watch<LocalizationBloc>().state;
    if (state.firstLogin == false) {
      setState(() {
        isLocaleSelected = !state.firstLogin;
      });
    }

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
          builder: (context, loginState) {
            // if (state is OTPCodeSend) {
            //   return VerificationPage(
            //     onResend: () => loginWithPhone(_resendToken),
            //     onConfirm: (smsCode) {
            //       context.read<LoginBloc>().add(ConfirmOTP(smsCode, state.verificationId));
            //     },
            //   );
            // }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!context.isSmall) Container(
                  width: context.isMedium
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: theme.primary,
                    borderRadius: const BorderRadius.only(topRight: radius, bottomRight: radius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, top: 30, right: 24),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                          Image.asset('assets/images/people_3.png', height: 330),
                          const SizedBox(height: 30),
                          Text(
                            context.loc.welcome_title,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            context.loc.welcome_subtitle,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.85),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: (context.isSmall) ? MainAxisAlignment.start : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (loginState is LoginSuccess)
                        Flexible(
                          child: OnBoarding(
                            constraints: (context.isSmall) ? null : const BoxConstraints(maxWidth: 568, maxHeight: 430),
                          ),
                        ),
                      if (loginState is LoginInitial)
                        Flexible(
                          child: LoginPanel(
                            constraints: (kIsWeb) ? const BoxConstraints(maxWidth: 600, maxHeight: 450) : null,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                            onChange: _onChange,
                            onSubmit: (value) {
                              if (value != null) {
                                setState(() {
                                  errorMessage = value;
                                });
                              } else {
                                loginWithPhone();
                              }
                            },
                            isLocaleSelected: isLocaleSelected,
                            errorMessage: errorMessage,
                          ),
                        ),
                      if (loginState is OTPCodeSend)
                        VerificationPage(
                        constraints: (kIsWeb) ? const BoxConstraints(maxWidth: 600, maxHeight: 450) : null,
                        onResend: () => loginWithPhone(_resendToken),
                        onConfirm: (smsCode) {
                          context.read<LoginBloc>().add(ConfirmOTP(smsCode, loginState.verificationId));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}