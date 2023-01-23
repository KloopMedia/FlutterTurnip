import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/important_notifications_cubit.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/combined_task_list_view.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip/src/widgets/drawers/app_drawer.dart';
import 'package:go_router/go_router.dart';

import '../../../../../widgets/notification_icon.dart';

class CombinedTasksView extends StatefulWidget {
  const CombinedTasksView({Key? key}) : super(key: key);

  @override
  State<CombinedTasksView> createState() => _CombinedTasksViewState();
}

class _CombinedTasksViewState extends State<CombinedTasksView> {
  late ScrollController _scrollController;
  final query = 'simple=true';

  @override
  initState() {
    context.read<TasksCubit>().initializeCombined();
    context.read<ImportantNotificationsCubit>().getNotifications();
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
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger &&
          context.read<TasksCubit>().state.status == TasksStatus.initialized) {
        context.read<TasksCubit>().getNextPage();
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          context.loc.tasks,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(notificationsRoute);
              final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
              context.go('/campaign/${selectedCampaign.id}/notifications?$query');
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
          return CombinedTasksListView(
            scrollController: _scrollController,
            onTap: (task) async {
              context.read<AppBloc>().add(AppSelectedTaskChanged(task));
              final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
              context.go('/campaign/${selectedCampaign.id}/tasks/${task.id}?$query');
            },
            onCreate: (item) async {
              // final task = await context.read<TasksCubit>().createTask(item);
              if (!mounted) return;
              // context.read<AppBloc>().add(AppSelectedTaskChanged(task));
              // final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
              // context.go('/campaign/${selectedCampaign.id}/tasks/${task.id}?$query');
            },
            onRequest: (item) async {
              await context.read<TasksCubit>().requestTask(item);
              if (!mounted) return;
              context.read<AppBloc>().add(AppSelectedTaskChanged(item));
              final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
              context.go('/campaign/${selectedCampaign.id}/tasks/${item.id}?$query');
            },
            onRefresh: () {
              context.read<TasksCubit>().refreshCombined();
            },
            openTasks: state.openTasks,
            closedTasks: state.closeTasks,
            availableTasks: state.availableTasks,
            creatableTasks: state.creatableTasks,
          );
        },
      ),
      endDrawer: const AppDrawer(),
    );
  }
}
