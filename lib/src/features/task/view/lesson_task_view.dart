import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class LessonTaskPage extends StatelessWidget {
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const LessonTaskPage({super.key, required this.onTap});

  /// Determines the status of a task stage chain.
  ChainInfoStatus _getChainStatus(TaskStageChainInfo item) {
    if (item.totalCount == 0) return ChainInfoStatus.notStarted;
    if (item.completeCount > 0 && item.completeCount < item.totalCount) {
      return ChainInfoStatus.returned;
    }
    if (item.completeCount < item.totalCount) return ChainInfoStatus.active;
    return ChainInfoStatus.complete;
  }

  /// Builds the widget representation of a single chain.
  List<Widget> _buildChain(List<TaskStageChainInfo> chainData) {
    final List<Widget> chainWidgets = [];

    for (int index = 0; index < chainData.length; index++) {
      final currentItem = chainData[index];
      final status = _getChainStatus(currentItem);
      final isComplete = status == ChainInfoStatus.complete;
      final isLast = index == (chainData.length - 1);

      TaskStageChainInfo? nextItemPreview;
      if (index < chainData.length - 1) {
        final nextItem = chainData[index + 1];
        final hasValidOutStages = nextItem.outStages.any((stage) => stage != null);

        if (!hasValidOutStages && index + 1 < chainData.length - 1) {
          nextItemPreview = nextItem;
          index++; // Skip to next valid index.
        }
      }

      chainWidgets.add(
        _buildChainItem(
          currentItem: currentItem,
          status: status,
          isComplete: isComplete,
          isLast: isLast,
          nextItemPreview: nextItemPreview,
        ),
      );
    }

    return chainWidgets;
  }

  /// Creates a widget for a single chain item.
  Widget _buildChainItem({
    required TaskStageChainInfo currentItem,
    required ChainInfoStatus status,
    required bool isComplete,
    required bool isLast,
    TaskStageChainInfo? nextItemPreview,
  }) {
    return Padding(
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
              title: currentItem.name,
              onTap: () => onTap(currentItem, status),
            ),
          ),
          if (nextItemPreview != null) const SizedBox(width: 8),
          if (nextItemPreview != null)
            Expanded(
              child: LessonListItem(
                title: nextItemPreview.name,
                onTap: () => onTap(nextItemPreview, status),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the chains to be displayed in the UI.
  List<Widget> _buildChains(List<IndividualChain> chainsData) {
    return chainsData.expand<Widget>((chain) {
      return [
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            chain.name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0),
          ),
        ),
        ..._buildChain(chain.stagesData),
        const SizedBox(height: 10),
      ];
    }).toList();
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
          final chains = _buildChains(state.data);
          return SliverList.list(children: chains);
        }

        return const SliverToBoxAdapter(
          child: SizedBox(),
        );
      },
    );
  }
}