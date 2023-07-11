import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import '../widgets.dart';

class FormErrorDialog extends StatelessWidget {
  final String content;

  const FormErrorDialog({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: context.loc.form_error,
      content: content,
      actions: [
        SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(context.loc.got_it),
          ),
        )
      ],
    );
  }
}