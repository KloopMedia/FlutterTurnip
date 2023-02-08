import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

Future<String?> deleteAccountDialog(BuildContext context) async {
  final value = await showDialog<String?>(
    context: context,
    builder: (context) {
      return const AlertDialogWithInputConfirmation();
    },
  );
  return value;
}

class AlertDialogWithInputConfirmation extends StatefulWidget {
  const AlertDialogWithInputConfirmation({Key? key}) : super(key: key);

  @override
  State<AlertDialogWithInputConfirmation> createState() => _AlertDialogWithInputConfirmationState();
}

class _AlertDialogWithInputConfirmationState extends State<AlertDialogWithInputConfirmation> {
  String? value;

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
            Navigator.of(context).pop(null);
          },
          child: Text(context.loc.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(value);
          },
          child: Text(context.loc.delete_account_confirmation),
        ),
      ],
    );
  }
}
