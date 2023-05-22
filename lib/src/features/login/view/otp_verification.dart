import 'package:flutter/material.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatefulWidget {
  final void Function(String code) onConfirm;
  final void Function()? onResend;

  const VerificationPage({
    super.key,
    required this.onConfirm,
    this.onResend,
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
    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final subtitleTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final textButtonStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: theme.primary,
    );
    final defaultPinTheme = PinTheme(
      height: 54,
      textStyle: TextStyle(
        fontSize: 16,
        color: theme.primary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: theme.neutral95,
      ),
    );

    return Container(
      padding: const EdgeInsets.only(top: 15.0),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  context.loc.received_code,
                  style: subtitleTextStyle,
                ),
                TextButton(
                  onPressed: widget.onResend,
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                  ),
                  child: Text(
                    context.loc.resend_code,
                    style: textButtonStyle,
                  ),
                ),
              ])
            ],
          ),
          SignUpButton(
            focusNode: focusNode,
            onPressed: pinCode.length != _length ? null : () => widget.onConfirm(pinCode),
          ),
        ],
      ),
    );
  }
}
