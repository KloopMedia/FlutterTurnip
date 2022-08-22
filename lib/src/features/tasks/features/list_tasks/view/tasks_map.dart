import 'package:flutter/material.dart';
import 'package:graphite/core/matrix.dart';
import 'package:graphite/graphite.dart';

class TasksMap extends StatefulWidget {
  const TasksMap({Key? key}) : super(key: key);

  @override
  State<TasksMap> createState() => _TasksMapState();
}

class _TasksMapState extends State<TasksMap> {
  final presetBasic =
      '[{"id": Container(),"next":["B"]},{"id":"B","next":["C","D","E"]},'
      '{"id":"C","next":["F"]},{"id":"D","next":["J"]},{"id":"E","next":["J"]},'
      '{"id":"J","next":["I"]},{"id":"I","next":["H"]},{"id":"F","next":["K"]},'
      '{"id":"K","next":["L"]},{"id":"H","next":["L"]},{"id":"L","next":["P"]},'
      '{"id":"P","next":["M","N"]},{"id":"M","next":[]},{"id":"N","next":[]}]';

  @override
  Widget build(BuildContext context) {
    var list = nodeInputFromJson(presetBasic);
    return DirectGraph(
      list: list,
      cellWidth: 136.0,
      cellPadding: 24.0,
      orientation: MatrixOrientation.Vertical,
    );
  }
}
