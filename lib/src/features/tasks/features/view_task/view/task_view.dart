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
  late TaskBloc taskBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    taskBloc.add(ExitTaskEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    taskBloc = context.read<TaskBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<TaskBloc>().state.name),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          // TODO: implement error handling
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: JSONSchemaUI(
              schema: state.schema!,
              ui: state.uiSchema!,
              data: state.responses ?? {},
              disabled: state.complete,
              onUpdate: ({required MapPath path, required Map<String, dynamic> data}) {
                context.read<TaskBloc>().add(UpdateTaskEvent(data));
              },
              onSubmit: ({required Map<String, dynamic> data}) {
                context.read<TaskBloc>().add(SubmitTaskEvent(data));
              },
            ),
          );
        },
      ),
    );
  }
}
