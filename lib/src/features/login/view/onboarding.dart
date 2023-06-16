import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../widgets/widgets.dart';
import 'language_picker.dart';

class OnBoarding extends StatelessWidget {
  final void Function() onContinue;

  const OnBoarding({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(children: [LanguagePicker()]),
          Image.asset('assets/images/people.png'),
          Column(
            children: [
              Text(
                'Присоединяйтесь к социальным кампаниям',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: theme.isLight ? theme.neutral30 : theme.neutral90,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Здесь люди объединяются и решают общественно значимые проблемы вместе. Вы можете присоединиться к интересующим вас кампаниям или даже создать свою!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: theme.isLight ? theme.neutral30 : theme.neutral90,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SignUpButton(onPressed: onContinue),
            ],
          )
        ],
      ),
    );
  }
}
