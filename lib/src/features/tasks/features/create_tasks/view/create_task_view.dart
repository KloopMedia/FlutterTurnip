import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip/src/features/tasks/features/create_tasks/cubit/index.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip/src/widgets/lists/generic_list_view.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class CreateTasksView extends StatefulWidget {
  const CreateTasksView({Key? key}) : super(key: key);

  @override
  State<CreateTasksView> createState() => _CreateTasksViewState();
}

class _CreateTasksViewState extends State<CreateTasksView> {
  @override
  initState() {
    context.read<CreateTasksCubit>().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createTasksRoute);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: BlocConsumer<CreateTasksCubit, CreateTasksState>(
        listener: (context, state) {
          if (state.status == TasksStatus.error) {
            showErrorDialog(
              context,
              state.errorMessage ?? 'An error occurred while fetching tasks',
            );
          }
        },
        builder: (context, state) {
          if (state.status == TasksStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GenericListView<TaskStage>(
            items: state.taskStages,
            onRefresh: () {
              context.read<CreateTasksCubit>().refresh();
            },
            onTap: (taskStage) {
              // context.read<AppBloc>().add(AppSelectedTaskChanged());
              Navigator.of(context).pushNamed(taskInstanceRoute);
            },
          );
        },
      ),
    );
  }
}
