import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/view/task_view.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TaskPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(
        selectedTask: context.read<AppBloc>().state.selectedTask!,
        gigaTurnipRepository: context.read<GigaTurnipRepository>(),
      ),
      child: const TaskView(),
    );
  }
}
