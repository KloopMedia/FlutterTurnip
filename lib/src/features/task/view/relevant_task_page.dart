import 'package:flutter/material.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../widgets/filter_bar.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  void redirectToTask(BuildContext context, Task task) {
    context.goNamed(
      TaskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '${task.id}',
      },
      extra: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = (context.isDesktop || context.isTablet) ? 30 : 20;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: FilterBar(
            onChanged: (value) {},
            filters: const [
              'Активные',
              'Возвращенные',
              'Отправленные',
              'Не отправленные',
              'Все',
              'Памятки'
            ],
          ),
        ),
        AdaptiveListView<Task, RelevantTaskCubit>(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 24),
          itemBuilder: (context, index, item) {
            final cardBody = CardDate(date: item.createdAt);

            if (context.isDesktop || context.isTablet) {
              return CardWithTitle(
                chips: [const CardChip('Placeholder'), const Spacer(), _StatusChip(item)],
                title: item.name,
                size: const Size.fromHeight(165),
                flex: 1,
                onTap: () => redirectToTask(context, item),
                body: cardBody,
              );
            } else {
              return CardWithTitle(
                chips: [const CardChip('Placeholder'), const Spacer(), _StatusChip(item)],
                title: item.name,
                onTap: () => redirectToTask(context, item),
                body: cardBody,
              );
            }
          },
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final Task item;

  const _StatusChip(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? Colors.white : Colors.black;

    if (item.complete) {
      return CardChip(
        'Отправлено',
        fontColor: fontColor,
        backgroundColor: theme.statusGreen,
      );
    } else if (item.reopened) {
      return CardChip(
        'Возвращено',
        fontColor: fontColor,
        backgroundColor: theme.statusYellow,
      );
    } else {
      return CardChip(
        'Не отправлено',
        fontColor: fontColor,
        backgroundColor: theme.statusRed,
      );
    }
  }
}
