import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/task/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

/// Determines the status of a task stage chain.
ChainInfoStatus getChainStatus(TaskStageChainInfo item) {
  if (item.totalCount == 0) return ChainInfoStatus.notStarted;
  if (item.completeCount > 0 && item.completeCount < item.totalCount) {
    return ChainInfoStatus.returned;
  }
  if (item.completeCount < item.totalCount) return ChainInfoStatus.active;
  return ChainInfoStatus.complete;
}

/// Builds the widget representation of a single chain.
List<Widget> buildLessonChain(
  List<TaskStageChainInfo> chainData,
  Function(TaskStageChainInfo item, ChainInfoStatus status) onTap, {
  bool minimalistic = false,
}) {
  final List<Widget> chainWidgets = [];

  for (int index = 0; index < chainData.length; index++) {
    final currentItem = chainData[index];
    final status = getChainStatus(currentItem);
    final isComplete = status == ChainInfoStatus.complete;
    final isLast = index == (chainData.length - 1);

    final prevItem = index > 0 ? chainData[index - 1] : null;

    TaskStageChainInfo? nextItemPreview;
    if (index < chainData.length - 1) {
      final nextItem = chainData[index + 1];
      final hasValidOutStages = nextItem.outStages.any((stage) => stage != null);

      if (!hasValidOutStages && index + 1 < chainData.length - 1) {
        nextItemPreview = nextItem;
        index++; // Skip to next valid index.
      }
    }

    final nextItem = index < chainData.length - 1 ? chainData[index + 1] : null;

    final prevItemComplete =
        prevItem != null && getChainStatus(prevItem) == ChainInfoStatus.complete;
    final nextItemComplete =
        nextItem != null && getChainStatus(nextItem) == ChainInfoStatus.complete;
    final isActive = !isComplete && prevItemComplete && !nextItemComplete;

    chainWidgets.add(
      _buildChainItem(
        currentItem: currentItem,
        status: status,
        isComplete: isComplete,
        isLast: isLast,
        isActive: isActive,
        nextItemPreview: nextItemPreview,
        onTap: onTap,
        minimalistic: minimalistic,
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
  required bool isActive,
  TaskStageChainInfo? nextItemPreview,
  bool minimalistic = false,
  required Function(TaskStageChainInfo item, ChainInfoStatus status) onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        if (!minimalistic)
          Stack(
            children: [
              LessonLine(isComplete: isComplete, isLast: isLast),
              LessonDecorator(
                isComplete: isComplete,
                isActive: isActive,
              ),
            ],
          ),
        const SizedBox(width: 10),
        Expanded(
          child: LessonListItem(
            title: currentItem.name,
            isComplete: isComplete,
            isActive: isActive,
            onTap: () => onTap(currentItem, status),
          ),
        ),
        if (nextItemPreview != null) const SizedBox(width: 8),
        if (nextItemPreview != null)
          Expanded(
            child: LessonListItem(
              title: nextItemPreview.name,
              isActive: isActive,
              isComplete: isComplete,
              onTap: () => onTap(nextItemPreview, status),
            ),
          ),
      ],
    ),
  );
}

/// Builds the chains to be displayed in the UI.
List<Widget> buildChains(
  List<IndividualChain> chainsData,
  Function(TaskStageChainInfo item, ChainInfoStatus status) onTap, {
  bool minimalistic = false,
}) {
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
      ...buildLessonChain(chain.stagesData, onTap, minimalistic: minimalistic),
      const SizedBox(height: 10),
    ];
  }).toList();
}
