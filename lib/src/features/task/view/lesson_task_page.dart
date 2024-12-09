import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/types.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../bloc/bloc.dart';
import '../widgets/lesson_page/lesson_decorator.dart';
import '../widgets/lesson_page/lesson_line.dart';
import '../widgets/lesson_page/lesson_list_item.dart';

class LessonTaskPage extends StatelessWidget {
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const LessonTaskPage({super.key, required this.onTap});

  ChainInfoStatus _getStatus(TaskStageChainInfo item) {
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

  List<Widget> _buildChain(List<TaskStageChainInfo> data) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      final item = data[index];
      final status = _getStatus(item);
      final isComplete = status == ChainInfoStatus.complete;
      final isLast = index == (data.length - 1);

      TaskStageChainInfo? lookAhead;
      try {
        final nextItem = data[index + 1];
        final invalidOutStages = nextItem.outStages.where((item) => item != null).toList();

        if (index + 1 < data.length - 1 && invalidOutStages.isEmpty) {
          lookAhead = nextItem;
          index++;
        } else {
          lookAhead = null;
        }
      } on RangeError {
        lookAhead = null;
      }

      items.add(
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                children: [
                  LessonLine(isComplete: isComplete, isLast: isLast),
                  LessonDecorator(isComplete: isComplete),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: LessonListItem(
                  title: item.name,
                  // description: item.description,
                  onTap: () => onTap(item, status),
                ),
              ),
              if (lookAhead != null) const SizedBox(width: 8),
              if (lookAhead != null)
                Expanded(
                  child: LessonListItem(
                    title: lookAhead.name,
                    // description: lookAhead.description,
                    onTap: () => onTap(item, status),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is RemoteDataFailed) {
          return const SliverToBoxAdapter(child: SizedBox());
        }

        if (state is RemoteDataInitialized<IndividualChain> && state.data.isNotEmpty) {
          final data = state.data;

          final chains = data.expand<Widget>((item) {
            return [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0),
                ),
              ),
              ..._buildChain(item.stagesData),
              const SizedBox(height: 10),
            ];
          }).toList();

          return SliverList.list(children: chains);
        }

        return const SliverToBoxAdapter(
          child: SizedBox(),
        );
      },
    );
  }
}
