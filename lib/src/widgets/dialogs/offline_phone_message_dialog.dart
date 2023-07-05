import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class OfflinePhoneMessageDialog extends StatelessWidget {
  final String phoneNumber;
  final String message;

  const OfflinePhoneMessageDialog({super.key, required this.phoneNumber, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 340,
        height: 334,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 94,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Отсутствует подключение к интернету',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF191C1B),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Скопируйте текст ниже и отправьте его на указанный номер.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5C5F5F),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 118,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DialogContentTextField(text: phoneNumber),
                  const SizedBox(height: 10),
                  DialogContentTextField(text: message),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  side: BorderSide(width: 1, color: theme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Назад',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogContentTextField extends StatelessWidget {
  final String text;

  const DialogContentTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF1F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF5C5F5F),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: text));
            },
            child: const CopyIcon(),
          )
        ],
      ),
    );
  }
}

class CopyIcon extends StatelessWidget {
  const CopyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final square = Container(
      width: 14,
      height: 14,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.75,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF5E80FA),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );

    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(3),
      child: Stack(
        children: [
          Positioned(left: 4, top: 4, child: square),
          Positioned(left: 0, top: 0, child: square),
        ],
      ),
    );
  }
}
