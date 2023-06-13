import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/dialogs/base_dialog.dart';

class JoinCampaignDialog extends StatelessWidget {
  const JoinCampaignDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Вы присоединились!',
      content: 'Кампании к которым вы присоединились можете найти во вкладке “Мои кампании”',
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
            child: const Text('Понятно'),
          ),
        )
      ],
    );
  }
}
