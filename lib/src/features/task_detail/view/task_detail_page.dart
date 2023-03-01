import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class TaskDetailPage extends StatelessWidget {
  final int taskId;
  final int campaignId;
  final Task? task;

  const TaskDetailPage({Key? key, required this.taskId, this.task, required this.campaignId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        repository: TaskDetailRepository(
          gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
        ),
        taskId: taskId,
        task: task,
      ),
      child: TaskView(campaignId),
    );
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView(this.campaignId, {Key? key}) : super(key: key);

  void redirect(BuildContext context, int? nextTaskId) {
    if (nextTaskId != null) {
      context.goNamed(
        Constants.taskDetailRoute.name,
        params: {
          'tid': '$nextTaskId',
          'cid': '$campaignId',
        },
      );
    } else {
      context.goNamed(
        Constants.taskRouteRelevant.name,
        params: {
          'cid': '$campaignId',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
        if (state is TaskSubmitted) {
          redirect(context, state.nextTaskId);
        }
      }, builder: (context, state) {
        if (state is TaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskFetchingError) {
          return Text(state.error);
        }
        if (state is TaskInitialized) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterJsonSchemaForm(
              key: UniqueKey(),
              schema: state.data.schema ?? {},
              uiSchema: state.data.uiSchema,
              formData: state.data.responses,
              disabled: state.data.complete,
              onChange: (formData, path) => context.read<TaskBloc>().add(UpdateTask(formData)),
              onSubmit: (formData) => context.read<TaskBloc>().add(SubmitTask(formData)),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
