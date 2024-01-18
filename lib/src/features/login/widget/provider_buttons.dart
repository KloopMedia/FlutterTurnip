import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../bloc/login_bloc.dart';
import 'login_provider_button.dart';

class LoginProviderButtons extends StatelessWidget {
  final bool isActive;
  final void Function(String? errorMessage) onPressed;
  const LoginProviderButtons({Key? key, required this.isActive, required this.onPressed}) : super(key: key);

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
          color: (isActive)
              ? theme.isLight ? Colors.white : Colors.black
              : theme.neutralVariant95,
          border: BorderSide(
            color: (isActive)
                ? theme.isLight ? Colors.black.withOpacity(0.5) : theme.neutral90
                : Colors.transparent,
          ),
          onPressed: () {
            if (isActive) {
              context.read<LoginBloc>().add(const LoginWithAuthProvider(AuthProvider.google));
            } else {
              final helperText = (context.loc.localeName == 'ky') ? ' / Choose the language' : '';
              onPressed(context.loc.choose_language + helperText);
            }
          },
          icon: Image.asset(
              (isActive) ? 'assets/icon/google_icon.png' : 'assets/icon/google_icon_inactive.png',
              height: 24.0
          ),
          child: Text(
            context.loc.continue_with_google,
            style: textStyle.copyWith(
              color:  (isActive)
                  ? theme.isLight ? theme.neutral30 : theme.neutral90
                  : theme.neutralVariant90,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
          height: 20,
        ),
        LoginProviderButton(
          color: (isActive)
              ? theme.isLight ? Colors.black : Colors.white
              : theme.neutralVariant95,
          onPressed: () {
            if (isActive) {
              context.read<LoginBloc>().add(const LoginWithAuthProvider(AuthProvider.apple));
            } else {
              final helperText = (context.loc.localeName == 'ky') ? ' / Choose the language' : '';
              onPressed(context.loc.choose_language + helperText);
            }
          },
          icon: Image.asset(
            (isActive) ? 'assets/icon/apple_icon.png' : 'assets/icon/apple_icon_inactive.png',
            height: 22.0,
            color: theme.isLight ? Colors.white : Colors.black,
          ),
          child: Text(
            context.loc.continue_with_apple,
            style: const CupertinoTextThemeData().textStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: (isActive)
                  ? theme.isLight ? theme.neutral90 : theme.neutral30
                  : theme.neutralVariant90,
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
