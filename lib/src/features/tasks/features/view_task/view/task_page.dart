import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/view/task_view.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TaskPage extends StatelessWidget {
  final int? taskId;
  final bool simpleViewMode;

  const TaskPage({Key? key, this.taskId, this.simpleViewMode = false}) : super(key: key);

  Future<Task> loadTask(BuildContext context) async {
    if (taskId != null) {
      final appBloc = context.read<AppBloc>();
      final task = await context.read<GigaTurnipRepository>().getTask(taskId!);
      appBloc.add(AppSelectedTaskChanged(task));
      return task;
    } else {
      return context.read<AppBloc>().state.selectedTask!;
    }
  }

  static Page page() => const MaterialPage<void>(child: TaskPage());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Task>(
      future: loadTask(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(
            selectedTask: snapshot.data!,
            gigaTurnipRepository: context.read<GigaTurnipRepository>(),
            user: context.read<AppBloc>().state.user!,
            campaign: context.read<AppBloc>().state.selectedCampaign!.id,
          ),
          child: TaskView(simpleViewMode: simpleViewMode),
        );
      },
    );
  }
}
