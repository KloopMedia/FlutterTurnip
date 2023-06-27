import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/localization_bloc/localization_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class SignUpButton extends StatelessWidget {
  final bool? isActive;
  final FocusNode? focusNode;
  final void Function(String? errorMessage) onPressed;

  const SignUpButton({
    Key? key,
    required this.onPressed,
    this.isActive,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    bool active = false;
    if (isActive != null) active = isActive!;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        focusNode: focusNode,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: (active) ? theme.primary : theme.neutral95,
        ),
        onPressed: () {
          if (active) {
            onPressed(null);
          } else {
            onPressed(context.loc.choose_language);
          }
        },
        child: Text(
          context.loc.further,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: (active) ?   Colors.white : theme.neutralVariant80,
          ),
        ),
      ),
    );
  }
}
