import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/remote_data_bloc/remote_data_cubit.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OpenTaskCubit>(
          create: (context) => RelevantTaskCubit(
            OpenTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider<ClosedTaskCubit>(
          create: (context) => RelevantTaskCubit(
            ClosedTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
      ],
      child: TaskView(
        campaignId: campaignId,
      ),
    );
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView({Key? key, required this.campaignId}) : super(key: key);

  void redirect(BuildContext context, Task task) {
    context.goNamed(
      Constants.taskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '${task.id}',
      },
      extra: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RelevantTaskListView(
            bloc: context.read<OpenTaskCubit>() as RelevantTaskCubit,
            header: const Text('Open tasks'),
            onTap: (task) {
              redirect(context, task);
            },
          ),
          RelevantTaskListView(
            bloc: context.read<ClosedTaskCubit>() as RelevantTaskCubit,
            header: const Text('Closed tasks'),
            onTap: (task) {
              redirect(context, task);
            },
          ),
        ],
      ),
    );
  }
}

class RelevantTaskListView extends StatelessWidget {
  final RelevantTaskCubit bloc;
  final Text header;
  final void Function(Task task) onTap;

  const RelevantTaskListView(
      {Key? key, required this.bloc, required this.header, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
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
                    subtitle: Text(task.complete ? 'closed' : 'open'),
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
              onChanged: (page) {
                bloc.fetchData(page);
              },
              enabled: state is! RemoteDataLoading,
            );
          },
        )
      ],
    );
  }
}
