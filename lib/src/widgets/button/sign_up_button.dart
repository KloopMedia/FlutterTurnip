import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class SignUpButton extends StatelessWidget {
  final double? width;
  final String buttonText;
  final bool? isActive;
  final FocusNode? focusNode;
  final void Function() onPressed;

  const SignUpButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.width,
    this.isActive,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      width: width,
      child: ElevatedButton(
        focusNode: focusNode,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: (isActive != null && !isActive!)
            ? theme.isLight ? theme.neutral95 : theme.neutral12
            : theme.primary,
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: (isActive != null && !isActive!) ? theme.neutralVariant80 : Colors.white,
          ),
        ),
      ),
    );
  }
}
