import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../features/campaign/bloc/filter_bloc/filter_bloc.dart';
import 'mobile_filter/filter_page.dart';

class FilterButton extends StatefulWidget {
  final void Function() onPressed;
  final void Function(bool openClose) openCloseFilter;

  const FilterButton({
    Key? key,
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
    final itemCount = context.read<FilterBloc>().state.query.length;

    if (formFactor == FormFactor.small) {
      return IconButton(
        onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Dialog.fullscreen(
              child: FilterPage(onTap: () => widget.onPressed()),
            );
          }
        );
      },
        icon: const Icon(Icons.tune_rounded));
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
        icon: (openClose && itemCount > 0)
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
                  itemCount.toString(),
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