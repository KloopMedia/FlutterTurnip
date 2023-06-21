import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../bloc/bloc.dart';
import 'chain_row.dart';
import 'types.dart';

class TaskStageChainView extends StatelessWidget {
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const TaskStageChainView({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataInitialized<IndividualChain> &&
            state.data.isNotEmpty) {
          final chains = state.data
              .map((data) => Chains(
                    count: state.count,
                    onTap: onTap,
                    showMoreButton: state.count == 1 ? false : true,
                    stagesData: data.stagesData,
                  ))
              .toList();

          return MultiSliver(children: chains);
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class Chains extends StatefulWidget {
  final int count;
  final bool showMoreButton;
  final List<TaskStageChainInfo> stagesData;
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const Chains({
    Key? key,
    required this.count,
    required this.stagesData,
    required this.onTap,
    required this.showMoreButton,
  }) : super(key: key);

  @override
  State<Chains> createState() => _ChainsState();
}

class _ChainsState extends State<Chains> {
  final List<TaskStageChainInfo> totalItemsList = [];
  final List<TaskStageChainInfo> showHideItemsList = [];
  late bool isCollapsed;
  late bool isLongChain;
  late final int totalItemsCount;
  late final int itemCountToShow;

  @override
  void initState() {
    totalItemsList.addAll(widget.stagesData);
    totalItemsCount = totalItemsList.length;
    itemCountToShow = 5;
    isLongChain = totalItemsCount > itemCountToShow;

    if (widget.showMoreButton && isLongChain) {
      showHideItemsList.addAll(totalItemsList.getRange(0, itemCountToShow));
      setState(() {
        isCollapsed = true;
      });
    } else {
      showHideItemsList.addAll(widget.stagesData);
      isCollapsed = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.count; i++) {
      return MultiSliver(
        children: [
          IndividualChainBuilder(
              data: showHideItemsList,
              onTap: widget.onTap,
              isCollapsed: isCollapsed && isLongChain),

          (totalItemsCount > itemCountToShow)
            ? (isCollapsed)
              ? ShowMoreButton(
                text: 'Show more',
                onTap: (){
                  setState(() {
                    showHideItemsList.clear();
                    showHideItemsList.addAll(totalItemsList);
                    isCollapsed = false;
                  });
                })
              : ShowMoreButton(
                text: 'Show less',
                onTap: (){
                  setState(() {
                    showHideItemsList.clear();
                    showHideItemsList.addAll(totalItemsList.getRange(0, itemCountToShow));
                    isCollapsed = true;
                  });
                })
              : const SizedBox(height: 40)
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

class IndividualChainBuilder extends StatelessWidget {
  final List<TaskStageChainInfo> data;
  final bool isCollapsed;
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const IndividualChainBuilder(
      {Key? key,
      required this.data,
      required this.onTap,
      required this.isCollapsed})
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

  Function? handleTap(
      int index, ChainInfoStatus status, TaskStageChainInfo item) {
    if (index == 0 ||
        status == ChainInfoStatus.active ||
        status == ChainInfoStatus.complete) {
      return onTap(item, status);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
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
            final secondsElementStatus = secondElement != null
                ? getTaskStatus(secondElement)
                : ChainInfoStatus.notStarted;

            final itemStatus =
                index == 0 && secondsElementStatus == ChainInfoStatus.notStarted
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
                status: itemStatus,
                isCollapsed: isCollapsed,
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

class ShowMoreButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const ShowMoreButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: theme.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500)),
      ),
    );
  }
}
