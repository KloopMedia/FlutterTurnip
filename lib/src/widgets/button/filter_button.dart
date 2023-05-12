import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class FilterButton extends StatelessWidget {
  final void Function()? onPressed;

  const FilterButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formFactor = context.formFactor;

    if (formFactor == FormFactor.small) {
      return IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded));
    } else {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17.5),
          side: BorderSide(color: theme.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.filter_list),
        label: const Text('Фильтр'),
      );
    }
  }
}
