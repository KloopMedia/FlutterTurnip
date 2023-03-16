import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

class AvailableTaskPage extends StatelessWidget {
  final int campaignId;

  const AvailableTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => AvailableTaskCubit(
            AvailableTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
      ],
      child: TaskView(campaignId: campaignId),
    );
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AvailableTaskCubit, RemoteDataState>(
          listener: (context, state) {
            if (state is AvailableTaskRequestAssignmentSuccess) {
              context.goNamed(
                Constants.taskDetailRoute.name,
                params: {
                  'cid': '$campaignId',
                  'tid': '${state.task.id}',
                },
              );
            }
          },
        ),
        BlocListener<CreatableTaskCubit, RemoteDataState>(
          listener: (context, state) {
            if (state is TaskCreating) {
              context.goNamed(
                Constants.taskDetailRoute.name,
                params: {
                  "cid": "$campaignId",
                  "tid": state.createdTaskId.toString(),
                },
              );
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            CreatableTaskListView(
              bloc: context.read<CreatableTaskCubit>(),
              onTap: (task) {
                context.read<CreatableTaskCubit>().createTask(task);
              },
            ),
            AvailableTaskListView(
              bloc: context.read<AvailableTaskCubit>(),
              onTap: (task) {
                context.read<AvailableTaskCubit>().requestTaskAssignment(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CreatableTaskListView extends StatelessWidget {
  final CreatableTaskCubit bloc;
  final void Function(TaskStage task) onTap;

  const CreatableTaskListView({
    Key? key,
    required this.bloc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is RemoteDataLoading) {
              return const CircularProgressIndicator();
            }
            if (state is RemoteDataFailed) {
              return Text(state.error);
            }
            if (state is RemoteDataLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final task = state.data[index];
                  return ListTile(
                    title: Text(task.name),
                    onTap: () => onTap(task),
                  );
                },
                itemCount: state.data.length,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Pagination(
              currentPage: state is RemoteDataInitialized ? state.currentPage : 0,
              total: state is RemoteDataInitialized ? state.total : 0,
              onChanged: (page) => bloc.fetchData(page),
              enabled: state is! RemoteDataFetching,
            );
          },
        )
      ],
    );
  }
}

class AvailableTaskListView extends StatelessWidget {
  final AvailableTaskCubit bloc;
  final void Function(Task task) onTap;

  const AvailableTaskListView({Key? key, required this.bloc, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Available tasks'),
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is RemoteDataLoading) {
              return const CircularProgressIndicator();
            }
            if (state is RemoteDataLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final task = state.data[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text('ID: ${task.id} ${task.complete ? 'closed' : 'open'}'),
                    onTap: () => onTap(task),
                  );
                },
                itemCount: state.data.length,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Pagination(
              currentPage: state is RemoteDataInitialized ? state.currentPage : 0,
              total: state is RemoteDataInitialized ? state.total : 0,
              onChanged: (page) => bloc.fetchData(page),
              enabled: state is! RemoteDataLoading,
            );
          },
        )
      ],
    );
  }
}
