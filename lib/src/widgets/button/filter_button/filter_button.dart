import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import 'mobile_filter/filter_page.dart';

class FilterButton extends StatefulWidget {
  final List<dynamic> queries;
  final void Function(dynamic items) onPressed;
  final void Function(bool openClose) openCloseFilter;

  const FilterButton({
    Key? key,
    required this.queries,
    required this.onPressed,
    required this.openCloseFilter,
  }) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool openClose = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formFactor = context.formFactor;

    if (formFactor == FormFactor.small) {
      return IconButton(
        onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Dialog.fullscreen(
              child: FilterPage(
                queries: widget.queries,
                onTap: (selectedItems) => widget.onPressed(selectedItems)
              ),
            );
          }
        );
      },
        icon: Stack(
          alignment: Alignment.topRight,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.tune_rounded),
            ),
            if (widget.queries.isNotEmpty)
              Image.asset('assets/images/filter_badge.png'),
          ],
        ));
    } else {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17.5),
          side: BorderSide(color: theme.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          setState(() {
            openClose = !openClose;
          });
          widget.openCloseFilter(openClose);
        },
        icon: (widget.queries.isNotEmpty)
          ? Container(
            width: 24.0,
            height: 24.0,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiary
            ),
            child: Center(
              child: Text(
                  widget.queries.length.toString(),
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.onPrimary)
              ),
            )
          )
          : const Icon(Icons.filter_list),
          label: Text(context.loc.filter),
      );
    }
  }
}