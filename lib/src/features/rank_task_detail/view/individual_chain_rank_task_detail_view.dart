import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/card_with_chip_and_title.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';

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

        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 14,
                      height: 14,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: theme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,//theme.primary
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Прочитать текст и заполнить',// недостающие буквы',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: theme.neutral40,
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Выполнено 11 Мая 12:30', //Проверяется //Выполняется //Ожидает проверки
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFB9B9B9)
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(height: 1, color: theme.neutral90),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 14,
              bottom: 0,
              left: 6.3,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: theme.primary,//neutral80
                  shape: BoxShape.rectangle,
                ),
                child: const Text(''),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
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
