import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../widgets/button/sign_in_button.dart';
import '../../../widgets/button/sign_up_button.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<StatefulWidget> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleTextStyle = TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final textStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final subtitleTextStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: theme.neutral30,
    );
    final textButtonStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: theme.primary,
    );
    final defaultPinTheme = PinTheme(
      height: 54,
      textStyle: TextStyle(
        fontSize: 16.sp,
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
              Form(
                key: formKey,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 4,
                    controller: pinController,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    validator: (value) {},
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    onCompleted: (pin) {},
                    onChanged: (value) {},
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
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.received_code,
                      style: subtitleTextStyle,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
                      ),
                      child: Text(
                        context.loc.resend_code,
                        style: textButtonStyle,
                      ),
                    ),
                  ]
              )
            ],
          ),
          Column(
            children: [
              SignUpButton(onPressed: null),
              const SizedBox(height: 20),
              SignInButton(onPressed: null),
            ],
          ),
        ],
      ),
    );
  }
}