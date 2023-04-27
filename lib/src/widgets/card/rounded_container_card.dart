import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class RoundedContainerCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const RoundedContainerCard({Key? key, required this.child, this.width = double.infinity, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    );

    return Container(
      decoration: const BoxDecoration(boxShadow: Shadows.elevation3, borderRadius: borderRadius),
      width: width,
      height: height,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: theme.background,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius),
        child: child,
      ),
    );
  }
}
