import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
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
        BlocProvider<OpenTaskBloc>(
          create: (context) => RelevantTaskBloc(
            OpenTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
        BlocProvider<ClosedTaskBloc>(
          create: (context) => RelevantTaskBloc(
            ClosedTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
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
            bloc: context.read<OpenTaskBloc>(),
            header: const Text('Open tasks'),
            onTap: (task) {
              redirect(context, task);
            },
          ),
          RelevantTaskListView(
            bloc: context.read<ClosedTaskBloc>(),
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

class RelevantTaskListView<TaskBloc extends Bloc> extends StatelessWidget {
  final TaskBloc bloc;
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
            if (state is RemoteDataFetching) {
              return const CircularProgressIndicator();
            }
            if (state is RelevantTaskLoaded) {
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
              currentPage: state is RelevantTaskInitialized ? state.currentPage : 0,
              total: state is RelevantTaskInitialized ? state.total : 0,
              onChanged: (page) => bloc.add(RefetchRelevantTaskData(page)),
              enabled: state is! RemoteDataFetching,
            );
          },
        )
      ],
    );
  }
}
