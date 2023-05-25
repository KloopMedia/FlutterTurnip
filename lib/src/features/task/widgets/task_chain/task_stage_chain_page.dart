import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import 'chain_row.dart';
import 'types.dart';

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
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
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
                    onTap: status == ChainInfoStatus.notStarted ? null : () => onTap(item, status),
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
