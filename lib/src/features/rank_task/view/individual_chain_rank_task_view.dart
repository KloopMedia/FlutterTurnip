import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/card_with_chip_and_title.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class IndividualChainRankTaskView extends StatefulWidget {
  const IndividualChainRankTaskView({Key? key}) : super(key: key);

  @override
  State<IndividualChainRankTaskView> createState() => _IndividualChainRankTaskViewState();
}

class _IndividualChainRankTaskViewState extends State<IndividualChainRankTaskView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titles = [
      '`Прочитать текст и заполнить недостающие буквы',
      'Пройти тест по восприятию языка на слух',
      'Название задания',
      'Название задания',
      'Название задания',
    ];

    return Column(
      children: [
        CardWithTitle(
          onTap: () => context.pushNamed(RankTaskDetailRoute.name),
          // chips: [StatusCardChip(item)],
          title: 'Написать 10 статей на ... тему ',
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Место для описания и условий В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци. Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.onSurfaceVariant,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: titles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RankTaskCardWithTimeline(
                      title: titles[index],
                      isLastRow: index == titles.length - 1,
                    );
                  }
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CardWithTitle(
          onTap: () => context.pushNamed(RankTaskDetailRoute.name),
          chips: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Необходимо получить ранг:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
                const SizedBox(width: 3),
                Row(
                  children: [
                    Container(
                      width: 32,
                      // margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: Shadows.elevation3,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Image(image: AssetImage('assets/images/rank_icon_sample.png'))),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Название ранга',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: theme.onSurfaceVariant,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextButton(
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
                          'Получить',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: theme.primary
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: theme.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
          title: 'Написать 10 статей на ... тему ',
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Место для описания и условий В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци. Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.onSurfaceVariant,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ],
    );
  }
}
