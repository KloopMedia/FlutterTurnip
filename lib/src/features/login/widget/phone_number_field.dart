import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class PhoneNumberField extends StatefulWidget {
  final void Function(String phoneNumber) onChanged;

  const PhoneNumberField({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String? countryCode = '+996';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    final selectorTextStyle = textStyle.copyWith(color: theme.neutral40);
    final titleStyle = textStyle.copyWith(color: theme.neutral30, fontWeight: FontWeight.w500);
    final boxDecoration = BoxDecoration(
      color: theme.neutral95,
      borderRadius: BorderRadius.circular(15),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.enter_phone_number,
          style: titleStyle,
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              margin: const EdgeInsets.only(right: 8),
              decoration: boxDecoration,
              child: CountryCodePicker(
                onChanged: (code) {
                  setState(() {
                    countryCode = code.dialCode;
                  });
                },
                initialSelection: countryCode,
                favorite: const ['KG'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: true,
                hideMainText: true,
                flagDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.zero,
                builder: (code) {
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5), // Image border
                        child: Image.asset(
                          code!.flagUri!,
                          package: 'country_code_picker',
                          height: 24,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(countryCode ?? "", style: selectorTextStyle),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17.5),
                decoration: boxDecoration,
                style: selectorTextStyle,
                placeholder: 'xxx-xxx-xxx',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (phoneNumber) {
                  if (countryCode != null) {
                    widget.onChanged(countryCode! + phoneNumber);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}