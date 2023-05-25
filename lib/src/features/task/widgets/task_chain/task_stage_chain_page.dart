import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import 'chain_lines.dart';
import 'chain_sides.dart';
import 'task_chain.dart';

enum ChainInfoStatus {
  complete,
  active,
  notStarted,
}

class TaskStageChainView extends StatelessWidget {
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const TaskStageChainView({Key? key, required this.onTap}) : super(key: key);

  ChainInfoStatus getTaskStatus(TaskStageChainInfo item) {
    if (item.totalCount == 0) {
      return ChainInfoStatus.notStarted;
    } else if (item.completeCount < item.totalCount) {
      return ChainInfoStatus.active;
    } else {
      return ChainInfoStatus.complete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataInitialized<IndividualChain> && state.data.isNotEmpty) {
          final individualChains = state.data;
          List<Widget> tasks = [];
          for (var chain in individualChains) {
            tasks.add(Container(
              margin: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: chain.stagesData.length,
                itemBuilder: (context, index) {
                  final item = chain.stagesData[index];
                  final status = getTaskStatus(item);

                  ChainPosition position;
                  if (index == 0) {
                    position = ChainPosition.start;
                  } else if (index == chain.stagesData.length - 1) {
                    position = ChainPosition.end;
                  } else {
                    position = ChainPosition.middle;
                  }

                  return ChainRow(
                    position: position,
                    title: item.name,
                    index: index,
                    status: status,
                    onTap: () => onTap(item, status),
                  );
                },
              ),
            ));
          }
          return SliverToBoxAdapter(child: Column(children: tasks));
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class Position {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const Position({this.top, this.bottom, this.left, this.right});
}

enum ChainPosition { start, middle, end }

class ChainRow extends StatelessWidget {
  final int index;
  final String title;
  final ChainInfoStatus status;
  final ChainPosition position;
  final void Function()? onTap;

  const ChainRow({
    Key? key,
    required this.title,
    required this.status,
    required this.index,
    required this.position,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final isEven = index % 2 == 0;

    final completeLineColor = theme.isLight ? const Color(0xFF2754F3) : const Color(0xFF7694FF);
    final notStartedLineColor = theme.isLight ? const Color(0xFFE1E3E3) : theme.neutral20;

    final lineColor =
        (status == ChainInfoStatus.complete) ? completeLineColor : notStartedLineColor;

    final dashWidth = context.isSmall ? 10.0 : 16.0;
    final dashSpace = context.isSmall ? 10.0 : 12.0;
    final strokeWidth = context.isSmall ? 5.0 : 7.0;

    final style = PaintStyle(
      color: lineColor,
      dashWidth: dashWidth,
      dashSpace: dashSpace,
      strokeWidth: strokeWidth,
    );

    final notStartedColor = theme.isLight ? theme.neutral90 : theme.neutralVariant40;
    final activeColor = theme.isLight ? theme.neutral40 : theme.neutral70;

    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: status == ChainInfoStatus.notStarted ? notStartedColor : activeColor,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.elliptical(50, 80)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: titleTextStyle,
              textAlign: isEven ? TextAlign.right : TextAlign.left,
            ),
          ),
          Align(
            alignment: isEven ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: LessonIcon(
                lessonNum: index,
                status: status,
              ),
            ),
          ),
          ChainSide(
            style: style,
            isEven: isEven,
            position: position,
          ),
          ChainRowIcon(position: position, isEven: isEven),
        ],
      ),
    );
  }
}

class ChainRowIcon extends StatelessWidget {
  final ChainPosition position;
  final bool isEven;

  const ChainRowIcon({Key? key, required this.position, required this.isEven}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    Position? iconPosition;
    if (position == ChainPosition.start) {
      iconPosition = const Position(left: 0, top: -25);
    } else if (position == ChainPosition.end) {
      iconPosition =
          isEven ? const Position(left: 0, bottom: -25) : const Position(right: 0, bottom: -25);
    }

    final color = theme.isLight ? const Color(0xFFE1E3E3) : theme.neutralVariant40;

    return Positioned(
      top: iconPosition?.top,
      bottom: iconPosition?.bottom,
      left: iconPosition?.left,
      right: iconPosition?.right,
      child: switch (position) {
        ChainPosition.start => Image.asset('assets/images/flag.png', height: 50.0),
        ChainPosition.end => Icon(Icons.star, color: color, size: 50.0),
        ChainPosition.middle => const SizedBox.shrink(),
      },
    );
  }
}
