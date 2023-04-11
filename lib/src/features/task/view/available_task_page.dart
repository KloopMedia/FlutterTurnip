import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../bloc/bloc.dart';

class AvailableTaskPage extends StatelessWidget {
  final int campaignId;

  const AvailableTaskPage({Key? key, required this.campaignId}) : super(key: key);

  void redirectToTask(BuildContext context, int id) {
    context.goNamed(
      TaskDetailRoute.name,
      params: {
        "cid": "$campaignId",
        "tid": "$id",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AvailableTaskCubit, RemoteDataState>(
          listener: (context, state) {
            if (state is AvailableTaskRequestAssignmentSuccess) {
              redirectToTask(context, state.task.id);
            }
          },
        ),
        BlocListener<CreatableTaskCubit, RemoteDataState>(
          listener: (context, state) {
            if (state is TaskCreating) {
              redirectToTask(context, state.createdTaskId);
            }
          },
        ),
      ],
      child: CustomScrollView(
        slivers: [
          BlocBuilder<CreatableTaskCubit, RemoteDataState<TaskStage>>(
            builder: (context, state) {
              if (state is RemoteDataLoading<TaskStage>) {
                return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              }
              if (state is RemoteDataFailed<TaskStage>) {
                return SliverToBoxAdapter(child: Center(child: Text(state.error)));
              }
              if (state is RemoteDataLoaded<TaskStage>) {
                return MultiSliver(
                  children: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.data[index];
                          return ListTile(
                            title: Text(item.name),
                            onTap: () {
                              context.read<CreatableTaskCubit>().createTask(item);
                            },
                          );
                        },
                        childCount: state.data.length,
                      ),
                    ),
                    Pagination(
                      currentPage: state.currentPage,
                      total: state.total,
                      onChanged: (page) => context.read<CreatableTaskCubit>().fetchData(page),
                      enabled: state is! RemoteDataLoading,
                    ),
                  ],
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          BlocBuilder<AvailableTaskCubit, RemoteDataState<Task>>(
            builder: (context, state) {
              if (state is RemoteDataLoading<Task>) {
                return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              }
              if (state is RemoteDataFailed<Task>) {
                return SliverToBoxAdapter(child: Center(child: Text(state.error)));
              }
              if (state is RemoteDataLoaded<Task>) {
                return MultiSliver(
                  children: [
                    Text(
                      context.loc.available_tasks,
                      textAlign: TextAlign.center,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.data[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text(item.id.toString()),
                            onTap: () {
                              context.read<AvailableTaskCubit>().requestTaskAssignment(item);
                            },
                          );
                        },
                        childCount: state.data.length,
                      ),
                    ),
                    Pagination(
                      currentPage: state.currentPage,
                      total: state.total,
                      onChanged: (page) => context.read<AvailableTaskCubit>().fetchData(page),
                      enabled: state is! RemoteDataLoading,
                    ),
                  ],
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
