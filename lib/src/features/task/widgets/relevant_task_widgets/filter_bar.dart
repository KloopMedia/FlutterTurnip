import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task/bloc/volume_bloc/volume_cubit.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../bloc/bloc.dart';

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

// Helper function to get filter names dynamically
List<String> getFilterNames(BuildContext context, Volume? volume) {
  String getDefault(String? customText, String defaultText) {
    return (customText?.isNotEmpty ?? false) ? customText! : defaultText;
  }

  return [
    getDefault(volume?.activeTasksText, context.loc.task_filter_active),
    getDefault(volume?.returnedTasksText, context.loc.task_filter_returned),
    getDefault(volume?.completedTasksText, context.loc.task_filter_submitted),
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
  late final Volume? _selectedVolume;
  late final List<String> _filterNames;

  @override
  void initState() {
    _activeFilter = taskFilterMap.keys.first;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _selectedVolume = context.read<SelectedVolumeCubit>().state.volume;
    _filterNames = getFilterNames(context, _selectedVolume);
    super.didChangeDependencies();
  }

  void _onFilterChanged(BuildContext context, String key, Map<String, dynamic>? value) {
    final selectedVolume = context.read<SelectedVolumeCubit>().state.volume;
    final volumeId = selectedVolume?.id;

    context.read<RelevantTaskCubit>().refetchWithFilter();
    context.read<IndividualChainCubit>().refetchWithFilter(
      query: {
        ...?individualChainFilterMap[key],
        if (volumeId != null) 'stages__volumes': volumeId,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final filterKeys = taskFilterMap.keys.toList();
    final filterValues = taskFilterMap.values.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.mytasks,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: theme.isLight ? theme.neutral30 : theme.neutral90,
            ),
          ),
          const SizedBox(height: 15),
          FixedChipBar(
            children: List.generate(
              filterKeys.length,
              (index) => DefaultChip(
                label: _filterNames[index],
                active: filterKeys[index] == _activeFilter,
                onPressed: () {
                  setState(() {
                    _activeFilter = filterKeys[index];
                  });
                  _onFilterChanged(context, filterKeys[index], filterValues[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
