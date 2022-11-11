import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/double_tasks_list_view.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/index.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip/src/widgets/drawers/app_drawer.dart';
import 'package:gigaturnip/src/widgets/pagination/pagination.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import '../../../../../widgets/notification_icon.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late ScrollController _scrollController;

  @override
  initState() {
    context.read<TasksCubit>().initialize();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _scrollController.addListener(() {
    //   var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
    //
    //   if (_scrollController.position.pixels > nextPageTrigger &&
    //       context.read<TasksCubit>().state.status == TasksStatus.initialized) {
    //     context.read<TasksCubit>().getNextPage();
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.loc.tasks,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: BackButton(
          onPressed: () {
            context.read<AppBloc>().add(const AppSelectedCampaignChanged(null));
            context.pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
              context.go('/campaign/${selectedCampaign.id}/notifications');
            },
            icon: const NotificationIcon(),
          ),
          Builder(builder: (context) {
            final avatar = context.read<AppBloc>().state.user!.photo;
            return IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    )
                  : const Icon(Icons.person),
            );
          })
        ],
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state.status == TasksStatus.error) {
            showErrorDialog(
              context,
              state.errorMessage ?? context.loc.fetching_error_tasks,
            );
          }
        },
        builder: (context, state) {
          if (state.status == TasksStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          switch (state.selectedTab) {
            case Tabs.assignedTasksTab:
              return DoubleTasksListView(
                firstList: state.openTasks,
                secondList: state.closeTasks,
                headerOne: context.loc.todo,
                headerTwo: context.loc.done,
                onRefresh: () {
                  context.read<TasksCubit>().refresh();
                },
                onTap: (task) async {
                  context.read<AppBloc>().add(AppSelectedTaskChanged(task));
                  final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
                  context.go('/campaign/${selectedCampaign.id}/tasks/${task.id}');
                },
              );
            case Tabs.availableTasksTab:
              return DoubleTasksListView(
                firstList: state.creatableTasks,
                secondList: state.availableTasks,
                headerOne: context.loc.create,
                headerTwo: context.loc.receive,
                scrollController: _scrollController,
                showLoader: state.status == TasksStatus.loadingNextPage,
                expand: true,
                pagination: Pagination(
                  total: state.totalPages,
                  onPageChange: (page) {
                    context.read<TasksCubit>().getPage(page);
                  },
                ),
                onRefresh: () {
                  context.read<TasksCubit>().refresh();
                },
                onTap: (item) async {
                  final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
                  if (item is TaskStage) {
                    final task = await context.read<TasksCubit>().createTask(item);
                    if (!mounted) return;
                    context.read<AppBloc>().add(AppSelectedTaskChanged(task));
                    context.go('/campaign/${selectedCampaign.id}/tasks/${task.id}');
                  } else {
                    context.read<TasksCubit>().requestTask(item);
                    context.read<AppBloc>().add(AppSelectedTaskChanged(item));
                    context.go('/campaign/${selectedCampaign.id}/tasks/${item.id}');
                  }
                },
              );
          }
        },
      ),
      endDrawer: const AppDrawer(),
      bottomNavigationBar: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return TasksBottomNavigationBar(
            index: state.tabIndex,
            onTap: (index) {
              context.read<TasksCubit>().onTabChange(index);
            },
          );
        },
      ),
    );
  }
}
