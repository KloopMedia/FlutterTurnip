import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

Future<bool> deleteAccountDialog(BuildContext context) async {
  final value = await showDialog<bool>(
    context: context,
    builder: (context) {
      return const AlertDialogWithInputConfirmation();
    },
  );
  return value ?? false;
}

class AlertDialogWithInputConfirmation extends StatefulWidget {
  const AlertDialogWithInputConfirmation({Key? key}) : super(key: key);

  @override
  State<AlertDialogWithInputConfirmation> createState() => _AlertDialogWithInputConfirmationState();
}

class _AlertDialogWithInputConfirmationState extends State<AlertDialogWithInputConfirmation> {
  late final confirmationValue = context.loc.delete_account_confirmation;
  String? value;

  bool validateDeletion() {
    if (value?.toLowerCase() == confirmationValue.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.loc.delete_account_dialog_title,
        style: const TextStyle(color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.loc.delete_account_dialog_body),
          TextField(
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(context.loc.cancel),
        ),
        ElevatedButton(
          onPressed: validateDeletion()
              ? () {
                  Navigator.of(context).pop(true);
                }
              : null,
          child: Text(context.loc.delete_account_confirmation),
        ),
      ],
    );
  }
}
