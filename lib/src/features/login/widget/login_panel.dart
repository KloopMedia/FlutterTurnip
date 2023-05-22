import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/button/index.dart';
import 'package:gigaturnip/src/widgets/divider/divider_with_label.dart';

import '../bloc/login_bloc.dart';
import 'phone_number_field.dart';
import 'provider_buttons.dart';

class LoginPanel extends StatefulWidget {
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;

  const LoginPanel({Key? key, this.padding = EdgeInsets.zero, this.constraints}) : super(key: key);

  @override
  State<LoginPanel> createState() => _LoginPanelState();
}

class _LoginPanelState extends State<LoginPanel> {
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
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: theme.neutral30,
    );
    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );

    return Container(
      margin: widget.padding,
      constraints: widget.constraints,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.loc.welcome,
                  style: titleTextStyle,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.loc.sign_in_or_sign_up,
                  style: subtitleTextStyle,
                ),
              ),
            ],
          ),
          Column(
            children: [
              PhoneNumberField(onChanged: (phoneNumber) {
                setState(() {
                  _phoneNumber = phoneNumber;
                });
              }),
              DividerWithLabel(
                label: context.loc.or,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              const LoginProviderButtons(),
            ],
          ),
          // const Spacer(),
          Column(
            children: [
              SignUpButton(onPressed: () {
                loginWithPhone();
              }),
            ],
          ),
        ],
      ),
    );
  }
}
