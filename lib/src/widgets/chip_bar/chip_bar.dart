import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/chip_bar/default_chip.dart';

class ChipBar extends StatelessWidget {
  const ChipBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 13,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DefaultChip(label: 'Tag'),
          );
        },
      ),
    );
  }
}
