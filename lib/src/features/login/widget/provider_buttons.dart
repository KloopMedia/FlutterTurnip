import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../bloc/login_bloc.dart';
import 'login_provider_button.dart';

class LoginProviderButtons extends StatelessWidget {
  const LoginProviderButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    // return CustomWrapper(
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginProviderButton(
          color: theme.isLight ? Colors.white : Colors.black,
          border: BorderSide(
            color: theme.isLight ? Colors.black.withOpacity(0.5) : theme.neutral90,
          ),
          onPressed: () =>
              context.read<LoginBloc>().add(const LoginWithAuthProvider(AuthProvider.google)),
          icon: Image.asset('assets/icon/google_icon.png', height: 24.0),
          child: Text(
            context.loc.continue_with_google,
            style: textStyle.copyWith(
              color: theme.isLight ? theme.neutral30 : theme.neutral90,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
          height: 20,
        ),
        LoginProviderButton(
          color: theme.isLight ? Colors.black : Colors.white,
          onPressed: () =>
              context.read<LoginBloc>().add(const LoginWithAuthProvider(AuthProvider.apple)),
          icon: Image.asset(
            'assets/icon/apple_icon.png',
            height: 22.0,
            color: theme.isLight ? Colors.white : Colors.black,
          ),
          child: Text(
            context.loc.continue_with_apple,
            style: const CupertinoTextThemeData().textStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.isLight ? theme.neutral90 : theme.neutral30,
                ),
          ),
        ),
      ],
    );
  }
}

class CustomWrap extends StatelessWidget {
  final List<Widget> children;

  const CustomWrap({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isSmall || context.isMedium) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}
