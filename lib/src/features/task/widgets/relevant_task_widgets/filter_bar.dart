import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../bloc/task_filter_bloc/task_filter_cubit.dart';

const taskFilterMap = {
  'Активные': {'complete': false, 'reopened': null},
  'Возвращенные': {'reopened': true, 'complete': false},
  'Отправленные': {'complete': true, 'reopened': null},
  'Все': null,
};

const individualChainFilterMap = {
  'Активные': {'completed': false},
  'Возвращенные': {'completed': false},
  'Отправленные': {'completed': true},
  'Все': null,
};

List<String> getFilterNames(BuildContext context, Volume? volume) {
  String getDefaultText(String? custom, String fallback) =>
      (custom?.isNotEmpty ?? false) ? custom! : fallback;

  return [
    getDefaultText(volume?.activeTasksText, context.loc.task_filter_active),
    getDefaultText(volume?.returnedTasksText, context.loc.task_filter_returned),
    getDefaultText(volume?.completedTasksText, context.loc.task_filter_submitted),
    context.loc.task_filter_all,
  ];
}

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late String _activeFilter;
  final _padding = EdgeInsets.symmetric(horizontal: 24);
  final _filterKeys = taskFilterMap.keys.toList();

  @override
  void initState() {
    super.initState();
    _activeFilter = taskFilterMap.keys.first;
  }

  void _applyFilter(BuildContext context, String filterKey) {
    final taskQuery = {...?taskFilterMap[filterKey]};
    final chainQuery = {...?individualChainFilterMap[filterKey]};

    context.read<TaskFilterCubit>().updateAll(taskQuery: taskQuery, chainQuery: chainQuery);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<TaskFilterCubit, TaskFilterState>(
      builder: (context, state) {
        final filterNames = getFilterNames(context, state.volume);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: _padding,
              child: Text(
                context.loc.mytasks,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: theme.isLight ? theme.neutral30 : theme.neutral90,
                ),
              ),
            ),
            const SizedBox(height: 15),
            FixedChipBar(
              padding: _padding,
              children: List.generate(_filterKeys.length, (index) {
                final key = _filterKeys[index];
                return DefaultChip(
                  label: filterNames[index],
                  active: key == _activeFilter,
                  onPressed: () {
                    setState(() {
                      _activeFilter = key;
                    });
                    _applyFilter(context, key);
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
