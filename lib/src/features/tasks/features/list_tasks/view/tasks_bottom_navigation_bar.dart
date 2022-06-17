import 'package:flutter/material.dart';

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
      // TODO: Change selected tab's color to global theme color.
      selectedItemColor: Colors.amber[800],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward),
          label: 'Open',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Closed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bolt),
          label: 'Available',
        ),
      ],
    );
  }
}
