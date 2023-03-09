import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/previous_task_bloc/previous_task_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc/task_bloc.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/helpers/webview/webview.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class TaskDetailPage extends StatelessWidget {
  final int taskId;
  final int campaignId;
  final Task? task;

  const TaskDetailPage({
    Key? key,
    required this.taskId,
    this.task,
    required this.campaignId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = context.read<api.GigaTurnipApiClient>();
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => TaskBloc(
          repository: TaskDetailRepository(
            gigaTurnipApiClient: apiClient,
          ),
          taskId: taskId,
          task: task,
        ),
      ),
      BlocProvider(
        create: (context) => PreviousTaskBloc(
          repository: TaskDetailRepository(
            gigaTurnipApiClient: apiClient,
          ),
          taskId: taskId,
        ),
      ),
    ], child: TaskView(campaignId));
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

  void openWebView(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    final state = bloc.state as TaskInitialized;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebView(
          html: state.data.stage.richText,
          onCloseCallback: () {
            bloc.add(CloseTaskInfo());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<TaskBloc>().add(OpenTaskInfo());
            },
            icon: const Icon(Icons.text_snippet),
          )
        ],
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskSubmitted) {
            redirect(context, state.nextTaskId);
          }
          if (state is TaskClosed) {
            redirect(context, null);
          }
          if (state is TaskInfoOpened) {
            openWebView(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: const [
              PreviousTaskView(),
              TaskDetailView(),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviousTaskView extends StatelessWidget {
  const PreviousTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousTaskBloc, PreviousTaskState>(
      builder: (context, state) {
        if (state is PreviousTaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PreviousTaskFetchingError) {
          return Text(state.error);
        }
        if (state is PreviousTaskInitialized) {
          return ListView.builder(
            itemCount: state.data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final task = state.data[index];
              return Column(
                children: [
                  TaskDivider(label: task.name),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterJsonSchemaForm(
                      schema: task.schema ?? {},
                      uiSchema: task.uiSchema,
                      formData: task.responses,
                      disabled: true,
                    ),
                  ),
                ],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskFetchingError) {
          return Text(state.error);
        }
        if (state is TaskLoaded) {
          return Column(
            children: [
              TaskDivider(label: context.loc.form_divider),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterJsonSchemaForm(
                  schema: state.data.schema ?? {},
                  uiSchema: state.data.uiSchema,
                  formData: state.data.responses,
                  disabled: state.data.complete,
                  onChange: (formData, path) => context.read<TaskBloc>().add(UpdateTask(formData)),
                  onSubmit: (formData) => context.read<TaskBloc>().add(SubmitTask(formData)),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
