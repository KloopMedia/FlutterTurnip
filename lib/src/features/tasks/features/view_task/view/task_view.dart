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
  late UIModel formController;

  @override
  void initState() {
    taskBloc = context.read<TaskBloc>();
    formController = UIModel(
      data: taskBloc.state.responses ?? {},
      disabled: taskBloc.state.complete,
      onUpdate: ({required MapPath path, required Map<String, dynamic> data}) {
        taskBloc.add(UpdateTaskEvent(data));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    taskBloc.add(ExitTaskEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<TaskBloc>().state.name),
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          formController.data = state.responses!;
          formController.disabled = state.complete;
          // TODO: implement error handling
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: JSONSchemaUI(
            schema: context.read<TaskBloc>().state.schema!,
            ui: context.read<TaskBloc>().state.uiSchema!,
            formController: formController,
            onSubmit: ({required Map<String, dynamic> data}) {
              context.read<TaskBloc>().add(SubmitTaskEvent(data));
            },
          ),
        ),
      ),
    );
  }
}
