import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TaskDetailPage extends StatelessWidget {
  final int taskId;
  final Task? task;

  const TaskDetailPage({Key? key, required this.taskId, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        repository: TaskDetailRepository(
          gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
        ),
        id: taskId,
        task: task,
      ),
      child: const TaskView(),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
        if (state is TaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskFetchingError) {
          return Text(state.error);
        }
        if (state is TaskLoaded && state.data.schema != null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterJsonSchemaForm(
              schema: state.data.schema!,
              uiSchema: state.data.uiSchema,
              formData: state.data.responses,
              onChange: (formData, path) => context.read<TaskBloc>().add(UpdateTask(formData)),
              onSubmit: (formData) => context.read<TaskBloc>().add(SubmitTask(formData)),
              // onValidationFailed: () => ,
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
