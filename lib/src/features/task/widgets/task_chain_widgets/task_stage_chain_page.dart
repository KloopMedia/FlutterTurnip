import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../bloc/bloc.dart';
import '../../utils.dart';
import 'chain_row.dart';
import 'types.dart';

class TaskStageChainView extends StatelessWidget {
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const TaskStageChainView({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataLoading) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        if (state is RemoteDataInitialized<IndividualChain> && state.data.isNotEmpty) {
          final chains = state.data.map((data) {
            if (data.newTaskViewMode) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.neutral40,
                      ),
                    ),
                  ),
                  ...buildLessonChain(data.stagesData, onTap),
                ],
              );
            }
            return Chains(
              count: state.count,
              onTap: onTap,
              isChainSingle: state.count == 1 ? true : false,
              chainName: data.name,
              stagesData: data.stagesData,
            );
          }).toList();

          return MultiSliver(children: chains);
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class Chains extends StatefulWidget {
  final int count;
  final bool isChainSingle;
  final String chainName;
  final List<TaskStageChainInfo> stagesData;
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const Chains({
    Key? key,
    required this.count,
    required this.chainName,
    required this.stagesData,
    required this.onTap,
    required this.isChainSingle,
  }) : super(key: key);

  @override
  State<Chains> createState() => _ChainsState();
}

class _ChainsState extends State<Chains> {
  final List<TaskStageChainInfo> totalItemsList = [];
  final List<TaskStageChainInfo> showHideItemsList = [];
  final int itemCountToShow = 3;
  late final int totalItemsCount;
  late bool isNeedToBeCollapsed;
  late bool showTopButton;
  late bool showBottomButton;
  late bool isTopCollapsed;
  late bool isBottomCollapsed;
  late bool firstTaskActive;
  late bool secondTaskActive;
  late bool middleTaskActive;
  late bool penultTaskActive;
  late bool lastTaskActive;
  late bool completed;
  int? activeTaskIndex;

  @override
  void initState() {
    totalItemsList.addAll(widget.stagesData);
    totalItemsCount = totalItemsList.length;
    isNeedToBeCollapsed = totalItemsCount > itemCountToShow;

    updateActiveTaskIndex();
    updateActiveTaskState();
    updateShowHideItemList();

    super.initState();
  }

  void updateActiveTaskIndex() {
    for (var task in totalItemsList) {
      if (task.completeCount == 0 && task.totalCount >= 0) {
        var activeTask = totalItemsList.firstWhere((element) => element.completeCount == 0);
        activeTaskIndex = totalItemsList.indexOf(activeTask);
      } else {
        activeTaskIndex = null;
      }
    }
  }

  void updateActiveTaskState() {
    completed = activeTaskIndex == null;
    firstTaskActive = activeTaskIndex == 0;
    secondTaskActive = activeTaskIndex == 1;
    penultTaskActive = activeTaskIndex == totalItemsCount - 2;
    lastTaskActive = activeTaskIndex == totalItemsCount - 1;
    middleTaskActive =
        !firstTaskActive && !secondTaskActive && !penultTaskActive && !lastTaskActive;
  }

  void updateShowHideItemList() {
    if (widget.isChainSingle) {
      showHideItemsList.addAll(totalItemsList);
      showTopButton = false;
      showBottomButton = false;
      isTopCollapsed = false;
      isBottomCollapsed = false;
    } else {
      if (!isNeedToBeCollapsed) {
        showHideItemsList.addAll(totalItemsList);
        showTopButton = false;
        isTopCollapsed = false;
        showBottomButton = false;
        isBottomCollapsed = false;
      } else if (isNeedToBeCollapsed && completed || firstTaskActive || secondTaskActive) {
        showHideItemsList.addAll(totalItemsList.getRange(0, itemCountToShow));
        showTopButton = false;
        isTopCollapsed = false;
        showBottomButton = true;
        isBottomCollapsed = true;
      } else if (isNeedToBeCollapsed && middleTaskActive) {
        showHideItemsList
            .addAll(totalItemsList.getRange(activeTaskIndex! - 1, activeTaskIndex! + 2));
        showTopButton = true;
        isTopCollapsed = true;
        showBottomButton = true;
        isBottomCollapsed = true;
      } else if (isNeedToBeCollapsed && lastTaskActive || penultTaskActive) {
        showHideItemsList
            .addAll(totalItemsList.getRange(totalItemsCount - itemCountToShow, totalItemsCount));
        showTopButton = true;
        isTopCollapsed = true;
        showBottomButton = false;
        isBottomCollapsed = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.neutral40);

    for (var i = 0; i < widget.count; i++) {
      return MultiSliver(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: (context.isSmall || context.isMedium)
                    ? 0.0
                    : MediaQuery.of(context).size.width / 6),
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Text(widget.chainName, style: textStyle),
          ),
          (isNeedToBeCollapsed)
              ? (showTopButton)
                  ? (isTopCollapsed)
                      ? CustomTextButton(
                          text: context.loc.show_previous,
                          onTap: () {
                            setState(() {
                              showHideItemsList.clear();
                              (lastTaskActive || !isBottomCollapsed)
                                  ? showHideItemsList
                                      .addAll(totalItemsList.getRange(0, totalItemsCount))
                                  : showHideItemsList
                                      .addAll(totalItemsList.getRange(0, activeTaskIndex! + 2));
                              isTopCollapsed = false;
                            });
                          })
                      : CustomTextButton(
                          text: context.loc.hide_previous,
                          onTap: () {
                            setState(() {
                              showHideItemsList.clear();
                              (lastTaskActive)
                                  ? showHideItemsList.addAll(totalItemsList.getRange(
                                      totalItemsCount - itemCountToShow, totalItemsCount))
                                  : showHideItemsList.addAll(totalItemsList.getRange(
                                      activeTaskIndex! - 1,
                                      (!isBottomCollapsed)
                                          ? totalItemsCount
                                          : activeTaskIndex! + 2));
                              isTopCollapsed = true;
                            });
                          })
                  : const SizedBox(height: 30)
              : const SizedBox(height: 30),
          const SizedBox(height: 20),
          IndividualChainBuilder(
              data: showHideItemsList,
              onTap: widget.onTap,
              activeTaskIndex: activeTaskIndex,
              lastTaskActive: lastTaskActive,
              isTopCollapsed: isTopCollapsed,
              isBottomCollapsed: isBottomCollapsed),
          const SizedBox(height: 20),
          (isNeedToBeCollapsed)
              ? (showBottomButton)
                  ? (isBottomCollapsed)
                      ? CustomTextButton(
                          text: context.loc.show_next,
                          onTap: () {
                            setState(() {
                              showHideItemsList.clear();
                              (firstTaskActive || completed || !isTopCollapsed)
                                  ? showHideItemsList
                                      .addAll(totalItemsList.getRange(0, totalItemsCount))
                                  : showHideItemsList.addAll(totalItemsList.getRange(
                                      activeTaskIndex! - 1, totalItemsCount));
                              isBottomCollapsed = false;
                            });
                          })
                      : CustomTextButton(
                          text: context.loc.hide_next,
                          onTap: () {
                            setState(() {
                              showHideItemsList.clear();
                              (firstTaskActive || completed)
                                  ? showHideItemsList
                                      .addAll(totalItemsList.getRange(0, itemCountToShow))
                                  : showHideItemsList.addAll(totalItemsList.getRange(
                                      (!isTopCollapsed) ? 0 : activeTaskIndex! - 1,
                                      activeTaskIndex! + 2));
                              isBottomCollapsed = true;
                            });
                          })
                  : const SizedBox(height: 30)
              : const SizedBox(height: 30)
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

class IndividualChainBuilder extends StatelessWidget {
  final List<TaskStageChainInfo> data;
  final int? activeTaskIndex;
  final bool lastTaskActive;
  final bool isTopCollapsed;
  final bool isBottomCollapsed;
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const IndividualChainBuilder(
      {Key? key,
      required this.data,
      required this.activeTaskIndex,
      required this.onTap,
      required this.lastTaskActive,
      required this.isTopCollapsed,
      required this.isBottomCollapsed})
      : super(key: key);

  ChainInfoStatus getTaskStatus(TaskStageChainInfo item) {
    if (item.totalCount == 0) {
      return ChainInfoStatus.notStarted;
    } else if (item.completeCount > 0 && item.completeCount < item.totalCount) {
      return ChainInfoStatus.returned;
    } else if (item.completeCount < item.totalCount) {
      return ChainInfoStatus.active;
    } else {
      return ChainInfoStatus.complete;
    }
  }

  Function? handleTap(int index, ChainInfoStatus status, TaskStageChainInfo item) {
    if (index == 0 || status == ChainInfoStatus.active || status == ChainInfoStatus.complete) {
      return onTap(item, status);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = data[index];
            final status = getTaskStatus(item);

            ChainPosition position;
            if (index == 0) {
              position = ChainPosition.start;
            } else if (index == data.length - 1) {
              position = ChainPosition.end;
            } else {
              position = ChainPosition.middle;
            }

            final secondElement = data.elementAtOrNull(1);
            final secondsElementStatus =
                secondElement != null ? getTaskStatus(secondElement) : ChainInfoStatus.notStarted;

            final itemStatus = index == 0 && secondsElementStatus == ChainInfoStatus.notStarted
                ? ChainInfoStatus.active
                : status;

            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: (context.isSmall || context.isMedium)
                      ? 0.0
                      : MediaQuery.of(context).size.width / 6),
              child: ChainRow(
                position: position,
                title: item.name,
                index: index,
                activeTaskIndex: activeTaskIndex,
                status: itemStatus,
                lastTaskActive: lastTaskActive,
                isTopCollapsed: isTopCollapsed,
                isBottomCollapsed: isBottomCollapsed,
                onTap: () => onTap(item, status),
              ),
            );
          },
          childCount: data.length,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const CustomTextButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(color: theme.primary, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
