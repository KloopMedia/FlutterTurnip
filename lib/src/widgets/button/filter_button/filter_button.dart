import 'package:flutter/material.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import 'mobile_filter/filter_page.dart';

class FilterButton extends StatelessWidget {
  final void Function() onPressedMobile;
  final void Function() onPressedWeb;

  const FilterButton({Key? key, required this.onPressedMobile, required this.onPressedWeb}) : super(key: key);

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
                child: FilterPage(onTap: () => onPressedMobile()),
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
          onPressedWeb();
          },
        icon: const Icon(Icons.filter_list),
        label: const Text('Фильтр'),
      );
    }
  }
}