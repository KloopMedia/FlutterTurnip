import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

import 'types.dart';

class ChainRowIcon extends StatelessWidget {
  final ChainPosition position;
  final bool isEven;
  final bool isCollapsed;

  const ChainRowIcon({Key? key, required this.position, required this.isEven, required this.isCollapsed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    Position? iconPosition;
    if (position == ChainPosition.start) {
      iconPosition = const Position(left: 0, top: -40);
    } else if (position == ChainPosition.end) {
      iconPosition =
          isEven ? const Position(left: 10, bottom: -15) : const Position(right: 10, bottom: -15);
    }

    final color = theme.isLight ? const Color(0xFFE1E3E3) : theme.neutralVariant40;

    return Positioned(
      top: iconPosition?.top,
      bottom: iconPosition?.bottom,
      left: iconPosition?.left,
      right: iconPosition?.right,
      child: switch (position) {
        ChainPosition.start => Image.asset('assets/images/flag.png', height: 70.0),
        ChainPosition.end => (isCollapsed) ? const SizedBox.shrink() : Image.asset('assets/images/star.png', color: color, height: 45.0),
        ChainPosition.middle => const SizedBox.shrink(),
      },
    );
  }
}
