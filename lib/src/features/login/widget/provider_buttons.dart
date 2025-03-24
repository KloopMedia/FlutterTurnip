import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import 'login_provider_button.dart';

class LoginProviderButtons extends StatelessWidget {
  final bool isActive;
  final void Function(String? errorMessage) onError;

  const LoginProviderButtons({
    super.key,
    required this.isActive,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildProviderButtons(context),
    );
  }

  /// Builds a list of login provider buttons.
  List<Widget> _buildProviderButtons(BuildContext context) {
    return [
      GoogleLoginButton(
        isActive: isActive,
        onError: onError,
        buttonText: context.loc.sign_in_with_google,
      ),
      const SizedBox(height: 20),
      AppleLoginButton(
        isActive: isActive,
        onError: onError,
        buttonText: context.loc.sign_in_with_apple,
      ),
    ];
  }
}
