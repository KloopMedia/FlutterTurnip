import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/tasks_cubit.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/tasks_bottom_navigation_bar.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/tasks_list_view.dart';




class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.tasks),
        actions: <Widget>[
          IconButton(
            key: Key(context.loc.homePage_logout_iconButton),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state.status == TasksStatus.error) {
            showErrorDialog(
              context,
              state.errorMessage ?? context.loc.fetching_error_tasks,
            );
          }
        },
        builder: (context, state) {
          if (state.status == TasksStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return TasksListView(
              tasks: state.tasks,
              onRefresh: () {
                context.read<TasksCubit>().loadTasks(forceRefresh: true);
              },
              onTap: (task) {
                context.read<AppBloc>().add(AppSelectedTaskChanged(task));
                Navigator.of(context).pushNamed(createOrUpdateTaskRoute);
              },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return TasksBottomNavigationBar(
            index: state.tabIndex,
            onTap: (index) {
              context.read<TasksCubit>().onTabChange(index);
            },
          );
        },
      ),
    );
  }
}
