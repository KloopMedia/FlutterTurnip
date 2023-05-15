import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import 'chain_lines.dart';
import 'task_chain.dart';

class TaskStageChainView extends StatelessWidget {
  final Function(BuildContext context, TaskStageChainView item)? onTap;

  const TaskStageChainView({Key? key, this.onTap}) : super(key: key);

  String? getTaskStatus(TaskStageChainInfo? item) {
    if (item != null) {
      if (item.completeCount == 0 && item.totalCount == 0) {
        return  'Неотправлено';
      } else if (item.completeCount < item.totalCount) {
        return 'Возвращено';
      } else if (item.completeCount > 0 && item.totalCount > 0 &&
          item.completeCount == item.totalCount) {
        return 'Отправлено';
      }
    }
    return null;
  }
 /* String? getTaskStatus(Map<String, dynamic>? item) {
    // String? getTaskStatus(TaskStageChainInfo? item) {
    if (item != null) {
      if (item['completeCount'] == 0 && item['totalCount'] == 0) {
        return  'Неотправлено';
      } else if (item['completeCount'] < item['totalCount']) {
        return 'Возвращено';
      } else if (item['completeCount'] > 0 && item['totalCount'] > 0 &&
          item['completeCount'] == item['totalCount']) {
        return 'Отправлено';
      }
    }
    return null;
  }*/
  // if (item != null) {
  //   if (item.completeCount == 0 && item.totalCount == 0) {
  //     return  theme.isLight ? theme.neutral20 : theme.neutral90;
  //   } else if (item.completeCount < item.totalCount) {
  //     return theme.isLight ? const Color(0xFF) : const Color(0xFF);
  //   } else if (item.completeCount > 0 && item.totalCount > 0 &&
  //       item.completeCount == item.totalCount) {
  //     return theme.isLight ? const Color(0xFF2754F3) : const Color(0xFF7694FF);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    Widget leftStarIcon = Row(
      children: [
        Icon(
          Icons.star,
          color: theme.isLight ? const Color(0xFFD9D9D9) : const Color(0xFFD9D9D9),
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
          color: theme.isLight ? const Color(0xFFD9D9D9) : const Color(0xFFD9D9D9),
          size: 50.0,
        )
      ],
    );

    return BlocBuilder<TaskStageChainCubit, RemoteDataState<Chain>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Chain> && state.data.isNotEmpty) {
        // final list = [
        //   {
        //     'name': 'AudioTest Seasons',
        //     'completeCount': 1,
        //     'totalCount': 1,
        //   },
        //   {
        //     'name': 'AudioTest Seasons',
        //     'completeCount': 0,
        //     'totalCount': 1,
        //   },
        //   {
        //     'name': 'AudioTest Seasons',
        //     'completeCount': 0,
        //     'totalCount': 0,
        //   },
        // ];
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                  // final item = list[index];
                  final item = state.data[0].stagesData?[index];
                  final status = getTaskStatus(item);

                  final lineColor = (status == 'Отправлено')
                      ? theme.isLight
                        ? const Color(0xFF2754F3) : const Color(0xFF7694FF)
                      : theme.isLight
                        ? const Color(0xFFE1E3E3) : theme.neutral20;//const Color(0xFF2E3132);

                  print('>>> completeCount  = ${state.data[0].stagesData?[0].completeCount} || totalCount = ${state.data[0].stagesData?[0].totalCount}');
                  print('>>> name  = ${state.data[0].stagesData?[0].name}');

                  if (index == 0) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 150.0,
                          child: TaskStageChain(
                            title: item!.name,
                            // title: '${item['name']}',
                            status: status,
                            lessonNum: index + 1,
                            even: index % 2 == 0 ? true : false,
                            lineColor: lineColor,
                            // onTap: onTap!(context, item),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.flag,
                              color: Color(0xFFDFC902),
                              size: 50.0,
                            ),
                            Expanded(
                              child: CustomPaint(
                                size: const Size(0, 5),
                                painter: StraightLine(color: lineColor),
                              ),
                            ),
                            const SizedBox(width: 65.0),
                          ],
                        )
                        // flagIcon,
                      ],
                    );
                  } else if (state.data[0].stagesData?.length == index + 1) {
                  // } else if (list.length == index + 1) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 150.0,
                          child: TaskStageChain(
                            title: item!.name,
                            // title: '${item['name']}',
                            status: status,
                            lessonNum: index + 1,
                            even: index % 2 == 0 ? true : false,
                            lineColor: lineColor,
                            // onTap: onTap!(context, item),
                          ),
                        ),

                        if (index % 2 == 0) leftStarIcon,
                        if (index % 2 != 0) rightStarIcon,
                      ],
                    );
                  } else {
                    return TaskStageChain(
                      title: item!.name,
                      // title: '${item['name']}',
                      status: status,
                      lessonNum: index + 1,
                      even: index % 2 == 0 ? true : false,
                      lineColor: lineColor,
                      // onTap: onTap!(context, item),
                    );
                  }
                },
                // childCount: list.length,
                childCount: state.data[0].stagesData?.length,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}