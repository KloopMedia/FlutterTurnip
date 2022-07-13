import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:uniturnip/json_schema_ui.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  void onUpdate({required Map data, required MapPath path}) {
    print(data);
    print(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<TaskBloc>().state.task.name),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          // TODO: implement error handling
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: JSONSchemaUI(
              schema: state.task.schema!,
              ui: state.task.uiSchema!,
              data: state.task.responses ?? {},
              onUpdate: onUpdate,
            ),
          );
        },
      ),
    );
  }
}
