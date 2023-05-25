import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
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
        if (state is RemoteDataInitialized<IndividualChain> && state.data.isNotEmpty) {
          final chains = state.data
              .map((data) => IndividualChainBuilder(data: data.stagesData, onTap: onTap))
              .toList();

          return MultiSliver(children: chains);
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class IndividualChainBuilder extends StatelessWidget {
  final List<TaskStageChainInfo> data;
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const IndividualChainBuilder({Key? key, required this.data, required this.onTap})
      : super(key: key);

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
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
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

            return ChainRow(
              position: position,
              title: item.name,
              index: index,
              status: status,
              onTap: status == ChainInfoStatus.notStarted ? null : () => onTap(item, status),
            );
          },
          childCount: data.length,
        ),
      ),
    );
  }
}
