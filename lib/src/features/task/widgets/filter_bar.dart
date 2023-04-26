import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';

import '../bloc/bloc.dart';

class FilterBar extends StatefulWidget {
  final Map<TaskFilterOptions, String> filters;
  final void Function(TaskFilterOptions value) onChanged;

  const FilterBar({Key? key, required this.onChanged, required this.filters}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  TaskFilterOptions _activeFilter = TaskFilterOptions.all;

  @override
  Widget build(BuildContext context) {
    return FixedChipBar(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        for (final filter in widget.filters.entries)
          DefaultChip(
            label: filter.value,
            active: filter.key == _activeFilter,
            onPressed: () {
              setState(() {
                _activeFilter = filter.key;
              });
              widget.onChanged(filter.key);
            },
          ),
      ],
    );
  }
}
