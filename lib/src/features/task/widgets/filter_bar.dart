import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';

class FilterBar extends StatefulWidget {
  final String value;
  final Map<String, Map<String, dynamic>?> filters;
  final List<String> names;
  final void Function(Map<String, dynamic>? value) onChanged;

  const FilterBar({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.filters,
    required this.names,
  }) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late String _activeFilter = widget.value;

  @override
  Widget build(BuildContext context) {
    final keys = widget.filters.keys.toList();
    final values = widget.filters.values.toList();

    return FixedChipBar(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        for (var i = 0; i < widget.filters.length; i++)
          DefaultChip(
            label: widget.names[i],
            active: keys[i] == _activeFilter,
            onPressed: () {
              setState(() {
                _activeFilter = keys[i];
              });
              widget.onChanged(values[i]);
            },
          ),
      ],
    );
  }
}
