import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

import 'types.dart';

class ChainRowIcon extends StatelessWidget {
  final ChainPosition position;
  final bool isEven;

  const ChainRowIcon({Key? key, required this.position, required this.isEven}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    Position? iconPosition;
    if (position == ChainPosition.start) {
      iconPosition = const Position(left: 0, top: -25);
    } else if (position == ChainPosition.end) {
      iconPosition =
          isEven ? const Position(left: 0, bottom: -25) : const Position(right: 0, bottom: -25);
    }

    final color = theme.isLight ? const Color(0xFFE1E3E3) : theme.neutralVariant40;

    return Positioned(
      top: iconPosition?.top,
      bottom: iconPosition?.bottom,
      left: iconPosition?.left,
      right: iconPosition?.right,
      child: switch (position) {
        ChainPosition.start => Image.asset('assets/images/flag.png', height: 50.0),
        ChainPosition.end => Icon(Icons.star, color: color, size: 50.0),
        ChainPosition.middle => const SizedBox.shrink(),
      },
    );
  }
}
