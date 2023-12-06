import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/rank_task/widgets/rank_task_instruction.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/card_with_chip_and_title.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../../rank_task/widgets/widgets.dart';
import '../custom_elevated_button.dart';

class ArticleChainRankTaskDetailView extends StatefulWidget {
  const ArticleChainRankTaskDetailView({Key? key}) : super(key: key);

  @override
  State<ArticleChainRankTaskDetailView> createState() => _ArticleChainRankTaskDetailViewState();
}

class _ArticleChainRankTaskDetailViewState extends State<ArticleChainRankTaskDetailView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titles = [
      'Название стейджа',
      'Проверка статьи редактором',
      'Публикация'
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
