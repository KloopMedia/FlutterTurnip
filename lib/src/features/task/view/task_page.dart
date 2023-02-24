import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/helpers/pagination.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

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
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
        BlocProvider<ClosedTaskBloc>(
          create: (context) => RelevantTaskBloc(
            ClosedTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
      ],
      child: const TaskView(),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RelevantTaskListView(
            bloc: context.read<OpenTaskBloc>() as RelevantTaskBloc,
            header: const Text('Open tasks'),
          ),
          RelevantTaskListView(
            bloc: context.read<ClosedTaskBloc>() as RelevantTaskBloc,
            header: const Text('Closed tasks'),
          ),
        ],
      ),
    );
  }
}

class RelevantTaskListView extends StatelessWidget {
  final RelevantTaskBloc bloc;
  final Text header;

  const RelevantTaskListView({Key? key, required this.bloc, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is RelevantTaskFetching) {
              return const CircularProgressIndicator();
            }
            if (state is RelevantTaskLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = state.data[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.complete ? 'closed' : 'open'),
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
