import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/privacy_policy_route.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: _baseTextStyle(fontColor),
        children: [
          _buildStaticText(context.loc.privacy_policy_acceptance_1),
          _buildInteractiveText(
            text: context.loc.privacy_policy_acceptance_2,
            color: theme.primary,
            onTap: () => context.goNamed(PrivacyPolicyRoute.name),
          ),
          _buildStaticText(context.loc.privacy_policy_acceptance_3),
        ],
      ),
    );
  }

  /// Base text style for consistent typography.
  TextStyle _baseTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.21,
    );
  }

  /// Builds static (non-interactive) text.
  TextSpan _buildStaticText(String text) {
    return TextSpan(text: "$text\n");
  }

  /// Builds interactive (tappable) text.
  TextSpan _buildInteractiveText({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TextSpan(
      text: text,
      style: _baseTextStyle(color),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}