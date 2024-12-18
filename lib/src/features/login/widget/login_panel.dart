import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import 'language_picker.dart';
import 'provider_buttons.dart';

class LoginPanel extends StatelessWidget {
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;
  final bool? isLocaleSelected;
  final String? errorMessage;
  final void Function(String? value) onSubmit;
  final void Function(String phoneNumber) onChange;

  const LoginPanel({
    super.key,
    this.padding = EdgeInsets.zero,
    this.constraints,
    this.isLocaleSelected,
    this.errorMessage,
    required this.onChange,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    final subtitleTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: fontColor,
    );
    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: fontColor,
    );

    return Container(
      margin: padding,
      constraints: constraints,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                  (kIsWeb) ? context.loc.choose_language_and_sign_up : context.loc.sign_in_or_sign_up,
                  style: subtitleTextStyle,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: LanguagePicker(
                    errorMessage: (errorMessage != null && isLocaleSelected == false)
                        ? errorMessage
                        : null,
                    isLocaleSelected: isLocaleSelected ?? true
                ),
              ),
              const SizedBox(height: 60),
              LoginProviderButtons(
                  isActive: isLocaleSelected ?? true,
                  onError: (errorMessage) {
                    onSubmit(errorMessage);
                  }
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!kIsWeb) Text(
                context.loc.privacy_policy_acceptance_1,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (kIsWeb) Text(
                    context.loc.privacy_policy_acceptance_1,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () async {
                      context.goNamed(PrivacyPolicyRoute.name);
                    },
                    child: Text(
                      context.loc.privacy_policy_acceptance_2,
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    context.loc.privacy_policy_acceptance_3,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}