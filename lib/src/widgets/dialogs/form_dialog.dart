import 'package:flutter/material.dart';

import '../widgets.dart';

class FormDialog extends StatelessWidget {
  final String? title;
  final String content;
  final String buttonText;

  const FormDialog({
    super.key,
    this.title,
    required this.content,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: title ?? '',
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
            child: Text(buttonText),
          ),
        )
      ],
    );
  }
}