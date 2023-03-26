import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
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
        BlocProvider<AvailableTaskBloc>(
          create: (context) => AvailableTaskBloc(
            AvailableTaskRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
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
    return BlocListener<AvailableTaskBloc, AvailableTaskState>(
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
      child: SingleChildScrollView(
        child: AvailableTaskListView(
          bloc: context.read<AvailableTaskBloc>(),
          header: Text(context.loc.available_tasks),
          onTap: (task) {
            context.read<AvailableTaskBloc>().add(RequestAvailableTaskAssignment(task));
          },
        ),
      ),
    );
  }
}

class AvailableTaskListView extends StatelessWidget {
  final AvailableTaskBloc bloc;
  final Text header;
  final void Function(Task task) onTap;

  const AvailableTaskListView(
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
            if (state is AvailableTaskLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final task = state.data[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text('ID: ${task.id} ${task.complete ? context.loc.closed : context.loc.opened}'),
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
              currentPage: state is AvailableTaskInitialized ? state.currentPage : 0,
              total: state is AvailableTaskInitialized ? state.total : 0,
              onChanged: (page) => bloc.add(RefetchAvailableTaskData(page)),
              enabled: state is! RemoteDataFetching,
            );
          },
        )
      ],
    );
  }
}
