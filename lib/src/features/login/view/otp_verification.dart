import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatefulWidget {
  final void Function(String code) onConfirm;
  final void Function() onResend;
  final BoxConstraints? constraints;

  const VerificationPage({
    super.key,
    required this.onConfirm,
    required this.onResend,
    this.constraints,
  });

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String pinCode = "";
  final int _length = 6;

  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: fontColor,
    );
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: fontColor,
    );

    final defaultPinTheme = PinTheme(
      height: 54,
      textStyle: TextStyle(
        fontSize: 16,
        color: theme.primary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: theme.isLight ? theme.neutral95 : theme.onSecondary,
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 69),
      constraints: widget.constraints,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.phone_number_verification,
            style: titleTextStyle,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.enter_code,
                style: textStyle,
              ),
              const SizedBox(height: 15.0),
              Pinput(
                autofocus: true,
                length: _length,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                defaultPinTheme: defaultPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onChanged: (value) {
                  setState(() {
                    pinCode = value;
                  });
                },
                onCompleted: (value) {
                  focusNode.requestFocus();
                },
                cursor: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: theme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ResendCodeButton(onResend: widget.onResend),
            ],
          ),
          SignUpButton(
            focusNode: focusNode,
            onPressed: (_) => pinCode.length != _length ? null : () => widget.onConfirm(pinCode),
          ),
        ],
      ),
    );
  }
}

class ResendCodeButton extends StatefulWidget {
  final void Function() onResend;

  const ResendCodeButton({Key? key, required this.onResend}) : super(key: key);

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  final oneSec = const Duration(seconds: 1);
  var countDown = 45;

  @override
  initState() {
    Timer.periodic(oneSec, (timer) {
      if (countDown == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          countDown--;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textButtonStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: countDown == 0 ? () => widget.onResend() : null,
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
          ),
          child: Text(
            countDown == 0 ? context.loc.resend_code : context.loc.resend_code_count(countDown),
            style: textButtonStyle,
          ),
        ),
      ],
    );
  }
}
