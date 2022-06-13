import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/cubit/tasks_cubit.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  void _handleTaskTap(BuildContext context, Task task) {
    context.read<AppBloc>().add(AppSelectedTaskChanged(task));
    Navigator.of(context).pushNamed('/tasks/new-task');
  }

  @override
  Widget build(BuildContext context) {
    context.read<TasksCubit>().loadTasks();
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state.status == TasksStatus.error) {
          showErrorDialog(context, state.errorMessage ?? 'An error occurred while fetching tasks');
        }
      },
      builder: (context, state) {
        if (state.status == TasksStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<TasksCubit>().loadTasks();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              var task = state.tasks[index];
              return ListTile(
                title: Text(
                  task.name,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  _handleTaskTap(context, task);
                },
              );
            },
          ),
        );
      },
    );
  }
}
