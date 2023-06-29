import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/button/index.dart';
import 'package:gigaturnip/src/widgets/divider/divider_with_label.dart';

import 'phone_number_field.dart';
import 'provider_buttons.dart';

class LoginPanel extends StatelessWidget {
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;
  final void Function() onSubmit;
  final void Function(String phoneNumber) onChange;

  const LoginPanel({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.constraints,
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
              PhoneNumberField(onChanged: onChange),
              const SizedBox(height: 20),
              SignUpButton(onPressed: (_) => onSubmit()),
              DividerWithLabel(
                label: context.loc.or,
                padding: const EdgeInsets.symmetric(vertical: 47.0),
                color: theme.isLight ? theme.neutral50 : theme.neutral60,
                thickness: 0.2,
              ),
              const LoginProviderButtons(),
            ],
          ),
        ],
      ),
    );
  }
}
