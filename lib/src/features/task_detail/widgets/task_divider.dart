import 'package:flutter/material.dart';

class TaskDivider extends StatelessWidget {
  final String label;

  const TaskDivider({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: const Divider(
            color: Colors.black,
            height: 36,
            thickness: 2,
          ),
        ),
      ),
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: const Divider(
            color: Colors.black,
            height: 36,
            thickness: 2,
          ),
        ),
      ),
    ]);
  }
}
