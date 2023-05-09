import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import '../bloc/login_bloc.dart';
import 'login_provider_button.dart';

class LoginProviderButtons extends StatelessWidget {
  const LoginProviderButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: [
        LoginProviderButton(
          color: Colors.white,
          onPressed: () =>
              context.read<LoginBloc>().add(const LoginWithAuthProvider(AuthProvider.google)),
          icon: Image.asset('assets/icon/google_icon.png', height: 24.0),
          child: Text(
            context.loc.continue_with_google,
            style: textStyle.copyWith(
              fontFamily: 'Roboto',
              color: Colors.black.withOpacity(0.54),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        LoginProviderButton(
          color: Colors.black,
          onPressed: () =>
              context.read<LoginBloc>().add(const LoginWithAuthProvider(AuthProvider.google)),
          icon: Image.asset('assets/icon/apple_icon.png', height: 24.0),
          child: Text(
            context.loc.continue_with_apple,
            style: textStyle.copyWith(
              fontFamily: 'SF Pro Display',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}