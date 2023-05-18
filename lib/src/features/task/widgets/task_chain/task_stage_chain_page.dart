import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import 'chain_lines.dart';
import 'task_chain.dart';

class TaskStageChainView extends StatelessWidget {
  final Function(TaskStage item, String status) onTap;

  const TaskStageChainView({Key? key, required this.onTap}) : super(key: key);

  // String? getTaskStatus(TaskStage item, TaskStage? previousItem) {
  //   if (item.completeCount == 0 && item.totalCount == 0) {
  //     return  'Неотправлено';
  //   } else if (item.completeCount! < item.totalCount!) {
  //     return 'Возвращено';
  //   } else if (item.completeCount! > 0 && item.totalCount! > 0 &&
  //       item.completeCount == item.totalCount) {
  //     return 'Отправлено';
  //   }
  //   return null;
  // }

  String? getTaskStatus(TaskStage item, TaskStage? previousItem) {
    if (previousItem != null) {
      if (item.completeCount! > 0 && item.totalCount! > 0 &&
          item.completeCount == item.totalCount) {
        return 'Отправлено';
      } else if (item.completeCount! < item.totalCount!) {
        return 'Возвращено';
      } else if (previousItem.completeCount! > 0 && previousItem.totalCount! > 0 &&
          previousItem.completeCount == previousItem.totalCount) {
        return 'Активно';
      } else if (item.completeCount == 0 && item.totalCount == 0) {
        return 'Неотправлено';
      }
    } else {
      if (item.completeCount! < item.totalCount!) {
        return 'Возвращено';
      } else if (item.completeCount! > 0 && item.totalCount! > 0 &&
          item.completeCount == item.totalCount) {
        return 'Отправлено';
      } else if (item.completeCount == 0 && item.totalCount == 0) {
        return 'Активно';
      }
    }
    return null;
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

    return BlocBuilder<TaskStageChainCubit, RemoteDataState<TaskStage>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<TaskStage> && state.data.isNotEmpty) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                  // final item = state.data[0].stagesData?[index];
                  final item = state.data[index];
                  final previousItem = (index == 0) ? null : state.data[index - 1];
                  final status = getTaskStatus(item, previousItem);
                  print('>>> status = $status');
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
                            title: item!.name,
                            status: status,
                            lessonNum: index + 1,
                            even: index % 2 == 0 ? true : false,
                            // isFirstTaskNotOpen: (status == 'Неотправлено') ? true : false,
                            lineColor: lineColor,
                            onTap: () => onTap(item, status!),
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
                                painter: StraightLine(color: lineColor),
                              ),
                            ),
                            const SizedBox(width: 60.0),
                          ],
                        )
                      ],
                    );
                  // } else if (state.data[0].stagesData?.length == index + 1) {
                  } else if (state.data.length == index + 1) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 150.0,
                          child: TaskStageChain(
                            title: item!.name,
                            status: status,
                            lessonNum: index + 1,
                            even: index % 2 == 0 ? true : false,
                            lineColor: lineColor,
                            onTap: () => onTap(item, status!),
                          ),
                        ),

                        if (index % 2 == 0) leftStarIcon,
                        if (index % 2 != 0) rightStarIcon,
                      ],
                    );
                  } else {
                    return TaskStageChain(
                      title: item!.name,
                      status: status,
                      lessonNum: index + 1,
                      even: index % 2 == 0 ? true : false,
                      lineColor: lineColor,
                      onTap: () => onTap(item, status!),
                    );
                  }
                },
                // childCount: state.data[0].stagesData?.length,
                childCount: state.data.length,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}