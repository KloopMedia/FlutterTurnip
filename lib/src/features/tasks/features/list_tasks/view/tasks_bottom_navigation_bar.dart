import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

typedef TabCallback = void Function(int index);

class TasksBottomNavigationBar extends StatelessWidget {
  final int index;
  final TabCallback onTap;

  const TasksBottomNavigationBar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.arrow_forward),
          label: context.loc.open,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.check),
          label: context.loc.closed,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bolt),
          label: context.loc.available,
        ),
      ],
    );
  }
}
