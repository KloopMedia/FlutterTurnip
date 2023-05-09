import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';

import '../bloc/login_bloc.dart';
import '../widget/phone_number_field.dart';
import '../widget/provider_buttons.dart';
import 'otp_verification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocConsumer<LoginBloc, LoginState>(
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
              if (state is OTPCodeSend) {
                return VerificationPage(
                  onConfirm: (smsCode) {
                    context.read<LoginBloc>().add(ConfirmOTP(smsCode, state.verificationId));
                  },
                );
              }
              return const RegistrationPage();
            },
          ),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _phoneNumber = "";

  void loginWithPhone() async {
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
          bloc.add(SendOTP(verificationId, resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final subtitleTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: theme.neutral30,
    );
    final dividerTextStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF0E222F).withOpacity(0.6),
    );
    final titleTextStyle = TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final divider = Expanded(
      child: Divider(thickness: 1.5, color: const Color(0xFF0E222F).withOpacity(0.1)),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          minVerticalPadding: 15.0,
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            context.loc.welcome,
            style: titleTextStyle,
          ),
          subtitle: Text(
            context.loc.sign_in_or_sign_up,
            style: subtitleTextStyle,
          ),
        ),
        PhoneNumberField(onChanged: (phoneNumber) {
          setState(() {
            _phoneNumber = phoneNumber;
          });
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              divider,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  context.loc.or,
                  style: dividerTextStyle,
                ),
              ),
              divider,
            ],
          ),
        ),
        const LoginProviderButtons(),
        const Spacer(),
        Column(
          children: [
            SignUpButton(onPressed: () {
              loginWithPhone();
            }),
          ],
        ),
      ],
    );
  }
}
