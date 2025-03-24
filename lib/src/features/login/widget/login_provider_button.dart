import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../bloc/login_bloc.dart';

/// Generic button widget for login providers
class LoginProviderButton extends StatelessWidget {
  final Color? backgroundColor;
  final BorderSide? border;
  final VoidCallback? onPressed;
  final Widget icon;
  final Widget child;

  const LoginProviderButton({
    super.key,
    this.backgroundColor,
    this.border,
    this.onPressed,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: context.isSmall || context.isMedium ? 0 : 1,
      child: SizedBox(
        height: 54.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
            side: border,
            backgroundColor: backgroundColor,
            shadowColor: Colors.transparent,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 15.0),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Base class for login buttons to avoid duplication
abstract class BaseLoginButton extends StatelessWidget {
  final bool isActive;
  final String buttonText;
  final void Function(String? errorMessage) onError;

  const BaseLoginButton({
    super.key,
    required this.isActive,
    required this.onError,
    required this.buttonText,
  });

  AuthProvider get provider;

  String get iconActive;

  String get iconInactive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final helperText = context.loc.localeName == 'ky' ? ' / Choose the language' : '';

    return LoginProviderButton(
      backgroundColor: isActive
          ? provider == AuthProvider.google
              ? (theme.isLight ? Colors.white : Colors.black)
              : (theme.isLight ? Colors.black : Colors.white)
          : theme.neutralVariant95,
      border: BorderSide(
        color: isActive
            ? theme.isLight
                ? Colors.black.withOpacity(0.5)
                : theme.neutral90
            : Colors.transparent,
      ),
      onPressed: () {
        if (isActive) {
          context.read<LoginBloc>().add(LoginWithAuthProvider(provider));
        } else {
          onError(context.loc.choose_language + helperText);
        }
      },
      icon: Padding(
        padding: provider == AuthProvider.apple ? EdgeInsets.only(bottom: 4.0) : EdgeInsets.zero,
        child: Image.asset(
          isActive ? iconActive : iconInactive,
          height: provider == AuthProvider.apple ? 22.0 : 24.0,
          color: provider == AuthProvider.apple && isActive
              ? (theme.isLight ? Colors.white : Colors.black)
              : null,
        ),
      ),
      child: Text(
        buttonText,
        style: _getTextStyle(theme),
      ),
    );
  }

  TextStyle _getTextStyle(ColorScheme theme) {
    return const CupertinoTextThemeData().textStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isActive
              ? provider == AuthProvider.google
                  ? (theme.isLight ? theme.neutral30 : theme.neutral90)
                  : (theme.isLight ? theme.neutral90 : theme.neutral30)
              : theme.neutralVariant90,
        );
  }
}

/// Google-specific login button
class GoogleLoginButton extends BaseLoginButton {
  const GoogleLoginButton({
    super.key,
    required super.isActive,
    required super.onError,
    required super.buttonText,
  });

  @override
  AuthProvider get provider => AuthProvider.google;

  @override
  String get iconActive => 'assets/icon/google_icon.png';

  @override
  String get iconInactive => 'assets/icon/google_icon_inactive.png';
}

/// Apple-specific login button
class AppleLoginButton extends BaseLoginButton {
  const AppleLoginButton({
    super.key,
    required super.isActive,
    required super.onError,
    required super.buttonText,
  });

  @override
  AuthProvider get provider => AuthProvider.apple;

  @override
  String get iconActive => 'assets/icon/apple_icon.png';

  @override
  String get iconInactive => 'assets/icon/apple_icon_inactive.png';
}
