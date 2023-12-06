import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class RankTaskInstruction extends StatelessWidget {
  const RankTaskInstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Написать статью на свободную тему',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Место для описания задания В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци.Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме. Место для описания задания. В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци.Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: theme.onSurfaceVariant,
          ),
        ),
      ]
    );
  }
}
