import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/card_with_chip_and_title.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../../rank_task/widgets/widgets.dart';

class IndividualChainRankTaskDetailView extends StatefulWidget {
  const IndividualChainRankTaskDetailView({Key? key}) : super(key: key);

  @override
  State<IndividualChainRankTaskDetailView> createState() => _IndividualChainRankTaskDetailViewState();
}

class _IndividualChainRankTaskDetailViewState extends State<IndividualChainRankTaskDetailView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 20),
        Text(
          'Статус задания',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
        ),
        const SizedBox(height: 20),

        const SizedBox(height: 20),

        /// Ещё button
        Row(
          children: [
            Column(
              children: [
                const SizedBox(width: 15),
                Container(
                  width: 2,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFECECEC),
                    borderRadius: BorderRadius.circular(1)
                  ),
                  child: const Text(''),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 2,
                  height: 5,
                  decoration: BoxDecoration(
                      color: const Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: const Text(''),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 2,
                  height: 5,
                  decoration: BoxDecoration(
                      color: const Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: const Text(''),
                ),
              ],
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft
              ),
              child: Row(
                children: [
                  Text(
                    'Ещё',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.primary
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: theme.primary,
                    // size: 20,
                  ),
                ],
              ),
            ),
          ],
        )
        
      ],
    );
  }
}
