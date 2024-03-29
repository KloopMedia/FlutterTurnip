import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/dialogs/base_dialog.dart';

class JoinCampaignDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;

  const JoinCampaignDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: title,
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
