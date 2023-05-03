import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/chain_lines.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/task_chain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/available_task_stages.dart';
import 'package:gigaturnip/src/features/task/widgets/available_task_stages.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../widgets/filter_bar.dart';
import '../widgets/page_header.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  void redirectToTask(BuildContext context, Task task) {
    context.pushNamed(
      TaskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '${task.id}',
      },
      extra: task,
    );
  }

  void redirectToAvailableTasks(BuildContext context, TaskStage task) {
    context.goNamed(
      AvailableTaskRoute.name,
      params: {'cid': '$campaignId', 'tid': '${task.id}'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = (context.isDesktop || context.isTablet) ? 30 : 20;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: PageHeader(padding: EdgeInsets.only(top: 20, bottom: 20)),
        ),
        AvailableTaskStages(
          onTap: (item) => redirectToAvailableTasks(context, item),
        ),
        SliverToBoxAdapter(
          child: FilterBar(
            onChanged: (query) {
              context.read<RelevantTaskCubit>().refetchWithFilter(query);
            },
            value: taskFilterMap.keys.first,
            filters: taskFilterMap,
          ),
        ),
        AdaptiveListView<Task, RelevantTaskCubit>(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 24),
          itemBuilder: (context, index, item) {
            final cardBody = CardDate(date: item.createdAt);

            return CardWithTitle(
              chips: [const CardChip('Placeholder'), const Spacer(), StatusCardChip(item)],
              title: item.name,
              size: context.isMobile ? null : const Size.fromHeight(165),
              flex: context.isMobile ? 0 : 1,
              onTap: () => redirectToTask(context, item),
              body: cardBody,
            );
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
                        height: 150.0,
                        child: TaskChain(
                          // title: item.stage.name,
                          // complete: item.complete,
                          title: item[index],
                          complete: true,
                          lessonNum: index + 1,
                          even: index % 2 == 0 ? true : false,
                        ),
                      ),
                      flagIcon,
                    ],
                  );
                } else if (3 == index + 1) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: 150.0,
                        child: TaskChain(
                          // title: item.stage.name,
                          // complete: item.complete,
                          title: item[index],
                          complete: true,
                          lessonNum: index + 1,
                          even: index % 2 == 0 ? true : false,
                        ),
                      ),

                      if (index % 2 == 0) leftStarIcon,
                      if (index % 2 != 0) rightStarIcon,
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
