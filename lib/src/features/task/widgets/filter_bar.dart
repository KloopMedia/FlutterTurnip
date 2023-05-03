import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';

class FilterBar extends StatefulWidget {
  final String value;
  final Map<String, Map<String, dynamic>?> filters;
  final void Function(Map<String, dynamic>? value) onChanged;

  const FilterBar({Key? key, required this.value, required this.onChanged, required this.filters})
      : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late String _activeFilter = widget.value;

  @override
  Widget build(BuildContext context) {
    return FixedChipBar(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        for (final filter in widget.filters.entries)
          DefaultChip(
            label: filter.key,
            active: filter.key == _activeFilter,
            onPressed: () {
              setState(() {
                _activeFilter = filter.key;
              });
              widget.onChanged(filter.value);
            },
          ),
      ],
    );
  }
}
