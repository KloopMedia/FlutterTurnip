import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/chip_bar/index.dart';

class FilterBar extends StatefulWidget {
  final List<String> filters;
  final void Function(String value) onChanged;

  const FilterBar({Key? key, required this.onChanged, required this.filters}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  String _activeFilter = '';

  @override
  Widget build(BuildContext context) {
    return FixedChipBar(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        for (final filter in widget.filters)
          DefaultChip(
            label: filter,
            active: filter == _activeFilter,
            onPressed: () {
              setState(() {
                _activeFilter = filter;
              });
              widget.onChanged(filter);
            },
          ),
      ],
    );
  }
}
