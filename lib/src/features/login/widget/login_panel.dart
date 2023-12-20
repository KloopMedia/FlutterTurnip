import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../router/routes/routes.dart';
import '../view/language_picker.dart';
import 'provider_buttons.dart';

class LoginPanel extends StatelessWidget {
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;
  final bool? isLocaleSelected;
  final String? errorMessage;
  final void Function(String? value) onSubmit;
  final void Function(String phoneNumber) onChange;

  const LoginPanel({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.constraints,
    this.isLocaleSelected,
    this.errorMessage,
    required this.onChange,
    required this.onSubmit,
  }) : super(key: key);

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
                      (kIsWeb) ? context.loc.choose_language_and_sign_up : context.loc.sign_in_or_sign_up,
                      style: subtitleTextStyle,
                    ),
                  ),
                ],
              ),
              if (kIsWeb)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: LanguagePicker(
                        errorMessage: (errorMessage != null && isLocaleSelected == false)
                            ? errorMessage
                            : null,
                        isLocaleSelected: isLocaleSelected ?? true,
                        campaignLocales: const [],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 60),
              LoginProviderButtons(
                isActive: isLocaleSelected ?? true,
                onPressed: (errorMessage) {
                  onSubmit(errorMessage);
                }
              ),
              const SizedBox.shrink(),
              // Column(
              //   children: [
              //     PhoneNumberField(onChanged: onChange),
              //     const SizedBox(height: 20),
              //     SignUpButton(onPressed: (_) => onSubmit()),
              //     DividerWithLabel(
              //       label: context.loc.or,
              //       padding: const EdgeInsets.symmetric(vertical: 47.0),
              //       color: theme.isLight ? theme.neutral50 : theme.neutral60,
              //       thickness: 0.2,
              //     ),
              //     const LoginProviderButtons(),
              //   ],
              // ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      if (kIsWeb) {
                        final url = Uri.parse('https://docs.google.com/document/d/1Jn8WkyVbnpLt-MDPowyDEVM0_vDdSm8d/edit?usp=sharing&ouid=101664496780696593737&rtpof=true&sd=true');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      } else {
                        context.goNamed(PrivacyPolicyRoute.name);
                      }
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
