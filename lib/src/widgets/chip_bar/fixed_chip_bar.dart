import 'package:flutter/material.dart';

class FixedChipBar extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;

  const FixedChipBar({Key? key, this.padding, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(children: children),
    );
  }
}
