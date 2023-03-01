import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TaskDetailPage extends StatelessWidget {
  final int taskId;

  const TaskDetailPage({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        repository: TaskDetailRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
        ),
        id: taskId,
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
        if (state is TaskLoaded) {
          return Text(state.data.name);
        }
        if (state is TaskFetchingError) {
          return Text(state.error);
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
