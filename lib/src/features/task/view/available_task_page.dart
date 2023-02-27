import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/helpers/pagination.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

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
          AvailableTaskListView(
            bloc: context.read<AvailableTaskBloc>(),
            header: const Text('Available tasks'),
          ),
        ],
      ),
    );
  }
}

class AvailableTaskListView extends StatelessWidget {
  final AvailableTaskBloc bloc;
  final Text header;

  const AvailableTaskListView({Key? key, required this.bloc, required this.header})
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
