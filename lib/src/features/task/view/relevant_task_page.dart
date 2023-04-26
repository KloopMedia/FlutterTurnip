import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/chain_lines.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/task_chain.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final item = ['sdfghj fhg fghjk fghjk fgjjhgkkjh gjghhjghgk','sdfghj fhg fghjk fghjk fgjjhgkkjh gjghhjghgk','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj',];
                // final item = state.data[index];
                if (index == 0) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.cyan,
                        height: 150.0,
                        child: TaskChain(
                          // title: item.stage.name,
                          // complete: item.complete,
                          title: item[index],
                          complete: true,
                          lessonNum: index + 1,
                          even: index % 2 == 0 ? true : false,
                          start: index == 0 ? true : false,
                          end: 6 == index + 1 ? true : false,
                          // end: state.data.length == index + 1 ? true : false,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.flag,
                            color: Color(0xFFDFC902),
                            size: 50.0,
                          ),
                          Expanded(
                            child: SizedBox(width: 40.0),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (3 == index + 1) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        color: Colors.cyan,
                        height: 150.0,
                        child: TaskChain(
                          // title: item.stage.name,
                          // complete: item.complete,
                          title: item[index],
                          complete: true,
                          lessonNum: index + 1,
                          even: index % 2 == 0 ? true : false,
                          start: index == 0 ? true : false,
                          end: 6 == index + 1 ? true : false,
                          // end: state.data.length == index + 1 ? true : false,
                        ),
                      ),

                      Row(
                        children: [
                          const SizedBox(width: 40.0),
                          straightLine,
                          const Icon(
                            Icons.star,
                            color: Color(0xFFE1E3E3),
                            size: 50.0,
                          ),

                          // (index % 2 == 0)
                          //   ? const Icon(
                          //     Icons.star,
                          //     color: Color(0xFFE1E3E3),
                          //     size: 50.0,
                          //   )
                          //   : const SizedBox(width: 40.0),
                          // straightLine,
                          // (index % 2 != 0)
                          //   ? const SizedBox(width: 40.0)
                          //   : const Icon(
                          //     Icons.star,
                          //     color: Color(0xFFE1E3E3),
                          //     size: 50.0,
                          //   )
                        ],
                      ),
                    ],
                  );
                } else {
                  return TaskChain(
                    // title: item.stage.name,
                    // complete: item.complete,
                    title: item[index],
                    complete: true,
                    lessonNum: index + 1,
                    even: index % 2 == 0 ? true : false,
                    start: index == 0 ? true : false,
                    end: 6 == index + 1 ? true : false,
                    // end: state.data.length == index + 1 ? true : false,
                  );
                }
              },
              // childCount: state.data.length,
              childCount: 3,
            ),
          ),
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
