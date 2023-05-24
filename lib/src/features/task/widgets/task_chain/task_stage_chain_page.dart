import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import 'chain_lines.dart';
import 'task_chain.dart';

class TaskStageChainView extends StatelessWidget {
  final Function(TaskStageChainInfo item, String status) onTap;

  const TaskStageChainView({Key? key, required this.onTap}) : super(key: key);

  String getTaskStatus(TaskStageChainInfo item, TaskStageChainInfo? previousItem) {
    if (previousItem != null) {
      if (item.completeCount> 0 && item.totalCount> 0 &&
          item.completeCount == item.totalCount) {
        return 'Отправлено';
      } else if (item.completeCount< item.totalCount) {
        return 'Возвращено';
      } else if (previousItem.completeCount> 0 && previousItem.totalCount> 0 &&
          previousItem.completeCount == previousItem.totalCount) {
        return 'Активно';
      } else if (item.completeCount == 0 && item.totalCount == 0) {
        return 'Неотправлено';
      }
    } else {
      if (item.completeCount< item.totalCount) {
        return 'Возвращено';
      } else if (item.completeCount> 0 && item.totalCount> 0 &&
          item.completeCount == item.totalCount) {
        return 'Отправлено';
      } else if (item.completeCount == 0 && item.totalCount == 0) {
        return 'Активно';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    Widget leftStarIcon = Row(
      children: [
        Icon(
          Icons.star,
          color: theme.isLight ? const Color(0xFFE1E3E3) : theme.neutralVariant40,
          size: 50.0,
        ),
        const Spacer()
      ],
    );

    Widget rightStarIcon = Row(
      children: [
        const Spacer(),
        Icon(
          Icons.star,
          color: theme.isLight ? const Color(0xFFE1E3E3) : theme.neutralVariant40,
          size: 50.0,
        )
      ],
    );

    return BlocBuilder<IndividualChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<IndividualChain> && state.data.isNotEmpty) {
          final individualChains = state.data;
          List<Widget> tasks = [];
          for (var chain in individualChains) {
            tasks.add(Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: context.isSmall || context.isMedium
                    ? 5
                    : MediaQuery.of(context).size.width / 6,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = chain.stagesData[index];
                  final previousItem = (index == 0) ? null : chain.stagesData[index - 1];
                  final status = getTaskStatus(item, previousItem);
                  final lineColor = (status == 'Отправлено')
                      ? theme.isLight
                      ? const Color(0xFF2754F3) : const Color(0xFF7694FF)
                      : theme.isLight
                      ? const Color(0xFFE1E3E3) : theme.neutral20;//const Color(0xFF2E3132);

                  if (index == 0) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 150.0,
                          child: TaskStageChain(
                            title: item.name,
                            status: status,
                            lessonNum: index + 1,
                            even: index % 2 == 0 ? true : false,
                            lineColor: lineColor,
                            onTap: () => onTap(item, status),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: Image.asset('assets/images/flag.png', height: 50.0),
                            ),
                            Expanded(
                              child: CustomPaint(
                                size: const Size(0.0, 0.0),
                                painter: StraightLine(
                                    color: lineColor,
                                    dashWidth: context.isSmall ? 10.0 : 16.0,
                                    dashSpace: context.isSmall ? 10.0 : 12.0,
                                    strokeWidth: context.isSmall ? 6.0 : 7.0
                                ),
                              ),
                            ),
                            const SizedBox(width: 60.0),
                          ],
                        )
                      ],
                    );
                  } else if (chain.stagesData.length == index + 1) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 150.0,
                          child: TaskStageChain(
                            title: item.name,
                            status: status,
                            lessonNum: index + 1,
                            even: index % 2 == 0 ? true : false,
                            lineColor: lineColor,
                            onTap: () => onTap(item, status),
                          ),
                        ),

                        if (index % 2 == 0) leftStarIcon,
                        if (index % 2 != 0) rightStarIcon,
                      ],
                    );
                  } else {
                    return TaskStageChain(
                      title: item.name,
                      status: status,
                      lessonNum: index + 1,
                      even: index % 2 == 0 ? true : false,
                      lineColor: lineColor,
                      onTap: () => onTap(item, status),
                    );
                  }
                },
                itemCount: chain.stagesData.length,
                ),
            ));
          }
          return SliverToBoxAdapter(
            child: Column(children: tasks)
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}