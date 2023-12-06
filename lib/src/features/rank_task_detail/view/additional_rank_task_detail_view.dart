import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../rank/widgets/widgets.dart';
import '../../rank_task/widgets/widgets.dart';
import '../custom_elevated_button.dart';

class AdditionalRankTaskDetailView extends StatelessWidget {
  const AdditionalRankTaskDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titles = [
      'Название стейджа',
      'Проверка статьи редактором',
      'Публикация'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Получите ранг',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: theme.neutral40
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Чтобы взять задание на выполнение получите следующие ранги:',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.neutral50
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            RankImage(),
            RankImage(),
          ],
        ),
        const SizedBox(height: 20),
        const RankTaskInstruction(),
        const SizedBox(height: 20),
        Text(
          context.loc.task_status,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
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
        const SizedBox(height: 60),
        CustomElevatedButton(
          title: context.loc.take_on_execution,
          onPressed: () {
            ///TODO
          },
        ),
      ],
    );
  }
}
