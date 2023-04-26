import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/chain_lines.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/task_chain.dart';
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
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final item = ['sdfghj fhg fghjk fghjk fgjjhgkkjh gjghhjghgk','sdfghj fhg fghjk fghjk fgjjhgkkjh gjghhjghgk','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj','sdfghj',];
                          // final item = state.data[index];
                          if (index == 0) {
                            return Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  color: Colors.cyan,
                                  height: 150.0,
                                  child: TaskChain(
                                    // title: item.stage.name,
                                    // complete: item.complete,
                                    title: item[index],
                                    complete: true,
                                    lessonNum: index + 1,
                                    even: index % 2 == 0 ? true : false,
                                    start: index == 0 ? true : false,
                                    end: 6 == index + 1 ? true : false,
                                    // end: state.data.length == index + 1 ? true : false,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.flag,
                                      color: Color(0xFFDFC902),
                                      size: 50.0,
                                    ),
                                    Expanded(
                                      child: SizedBox(width: 40.0),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else if (3 == index + 1) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  color: Colors.cyan,
                                  height: 150.0,
                                  child: TaskChain(
                                    // title: item.stage.name,
                                    // complete: item.complete,
                                    title: item[index],
                                    complete: true,
                                    lessonNum: index + 1,
                                    even: index % 2 == 0 ? true : false,
                                    start: index == 0 ? true : false,
                                    end: 6 == index + 1 ? true : false,
                                    // end: state.data.length == index + 1 ? true : false,
                                  ),
                                ),

                                Row(
                                  children: [
                                    const SizedBox(width: 40.0),
                                    straightLine,
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFE1E3E3),
                                      size: 50.0,
                                    ),

                                    // (index % 2 == 0)
                                    //   ? const Icon(
                                    //     Icons.star,
                                    //     color: Color(0xFFE1E3E3),
                                    //     size: 50.0,
                                    //   )
                                    //   : const SizedBox(width: 40.0),
                                    // straightLine,
                                    // (index % 2 != 0)
                                    //   ? const SizedBox(width: 40.0)
                                    //   : const Icon(
                                    //     Icons.star,
                                    //     color: Color(0xFFE1E3E3),
                                    //     size: 50.0,
                                    //   )
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return TaskChain(
                              // title: item.stage.name,
                              // complete: item.complete,
                              title: item[index],
                              complete: true,
                              lessonNum: index + 1,
                              even: index % 2 == 0 ? true : false,
                              start: index == 0 ? true : false,
                              end: 6 == index + 1 ? true : false,
                              // end: state.data.length == index + 1 ? true : false,
                            );
                          }
                        },
                        // childCount: state.data.length,
                        childCount: 3,
                      ),
                    ),
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
