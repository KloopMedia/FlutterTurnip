import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../bloc/bloc.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  void redirectToTask(BuildContext context, Task task) {
    context.goNamed(
      TaskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '${task.id}',
      },
      extra: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FutureBuilder<api.PaginationWrapper<api.Notification>>(
          future: context.read<api.GigaTurnipApiClient>().getUserNotifications(query: {
            'campaign': campaignId,
            'viewed': false,
            'importance': 0,
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = snapshot.data!.results[index];
                    return ListTile(
                      leading: const Icon(Icons.notifications_active),
                      tileColor: Colors.lightBlueAccent,
                      title: Text(item.title),
                      onTap: () {
                        final params = GoRouterState.of(context).params;
                        context.goNamed(
                          NotificationDetailRoute.name,
                          params: {...params, 'nid': '${item.id}'},
                        );
                      },
                    );
                  },
                  childCount: snapshot.data!.results.length,
                ),
              );
            }
            return const SliverToBoxAdapter();
          },
        ),
        BlocBuilder<OpenTaskCubit, RemoteDataState<Task>>(
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
                    context.loc.open_tasks,
                    textAlign: TextAlign.center,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = state.data[index];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text("${item.id} | ${context.loc.complete}: ${item.complete}"),
                          onTap: () => redirectToTask(context, item),
                        );
                      },
                      childCount: state.data.length,
                    ),
                  ),
                  Pagination(
                    currentPage: state.currentPage,
                    total: state.total,
                    onChanged: (page) => context.read<OpenTaskCubit>().fetchData(page),
                    enabled: state is! RemoteDataLoading,
                  ),
                ],
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
        BlocBuilder<ClosedTaskCubit, RemoteDataState<Task>>(
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
                    context.loc.closed_tasks,
                    textAlign: TextAlign.center,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = state.data[index];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text("${item.id} | ${context.loc.complete}: ${item.complete}"),
                          onTap: () => redirectToTask(context, item),
                        );
                      },
                      childCount: state.data.length,
                    ),
                  ),
                  Pagination(
                    currentPage: state.currentPage,
                    total: state.total,
                    onChanged: (page) => context.read<ClosedTaskCubit>().fetchData(page),
                    enabled: state is! RemoteDataLoading,
                  ),
                ],
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}
