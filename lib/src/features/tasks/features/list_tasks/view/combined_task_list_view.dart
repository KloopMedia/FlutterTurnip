import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/notifications/view/notification_view.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/important_notifications_cubit.dart';
import 'package:gigaturnip/src/widgets/cards/form_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';

typedef ItemCallback = void Function(dynamic item);
typedef RefreshCallback = void Function();

class CombinedTasksListView extends StatelessWidget {
  final ItemCallback onTap;
  final ItemCallback onCreate;
  final ItemCallback onRequest;
  final RefreshCallback onRefresh;
  final List<Task> openTasks;
  final List<Task> closedTasks;
  final List<Task> availableTasks;
  final List<TaskStage> creatableTasks;
  final ScrollController? scrollController;
  final bool showLoader;

  const CombinedTasksListView({
    Key? key,
    required this.onTap,
    required this.onCreate,
    required this.onRefresh,
    required this.openTasks,
    required this.closedTasks,
    required this.availableTasks,
    required this.creatableTasks,
    this.scrollController,
    this.showLoader = false,
    required this.onRequest,
  }) : super(key: key);

  final IconData iconToDo = Icons.today_rounded;
  final IconData iconDone = Icons.assignment_turned_in_outlined;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          BlocBuilder<ImportantNotificationsCubit, ImportantNotificationsState>(
            builder: (context, state) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = state.notifications[index];
                    return ItemCard(
                        item: item,
                        onTap: (notification) {
                          context
                              .read<ImportantNotificationsCubit>()
                              .onReadNotification(notification.id);
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => NotificationView(
                                      notification: notification, campaignName: '')))
                              .then((value) =>
                                  context.read<ImportantNotificationsCubit>().getNotifications());
                        });
                  },
                  childCount: state.notifications.length,
                ),
              );
            },
          ),
          CreatableTaskList(items: creatableTasks, onTap: onCreate, icon: iconToDo),
          SliverTaskListHeader(title: context.loc.todo),
          SliverTaskList(
            items: openTasks,
            onTap: onTap,
            icon: iconToDo,
            emptyTitle: context.loc.no_uncompleted_tasks,
          ),
          SliverTaskListHeader(title: context.loc.receive),
          SliverTaskList(
            items: availableTasks,
            onTap: onRequest,
            icon: iconDone,
            emptyTitle: context.loc.no_available_tasks,
          ),
          SliverTaskListHeader(title: context.loc.done),
          SliverTaskList(
            items: closedTasks,
            onTap: onTap,
            icon: iconDone,
            emptyTitle: context.loc.no_completed_tasks,
          ),
          if (showLoader)
            const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}

class SliverTaskListHeader extends StatelessWidget {
  final String? title;

  const SliverTaskListHeader({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return const SizedBox.shrink();
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title!,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

class CreatableTaskList extends StatelessWidget {
  final List<TaskStage> items;
  final ItemCallback onTap;
  final IconData icon;

  const CreatableTaskList({
    Key? key,
    required this.items,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var item in items)
              SizedBox(
                height: 50.0,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    onTap(item);
                  },
                  child: Text(
                    item.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SliverTaskList extends StatelessWidget {
  final List<Task> items;
  final ItemCallback onTap;
  final IconData icon;
  final String emptyTitle;

  const SliverTaskList({
    Key? key,
    required this.items,
    required this.onTap,
    required this.icon,
    required this.emptyTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(emptyTitle, style: Theme.of(context).textTheme.titleSmall),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = items[index];
          return FormCard(
            margin: const EdgeInsets.all(8),
            id: item.id,
            title: item.name,
            description: item.stage.description,
            date: item.createdAt,
            status: item.complete,
            task: item,
            onTap: () {
              onTap(item);
            },
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Notifications item;
  final ItemCallback onTap;

  const ItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: InkWell(
            onTap: () {
              onTap(item);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subtitle: Text(item.text),
                      trailing: Column(
                        children: [
                          Text(
                            '#${item.id}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            DateFormat.Hm().add_d().add_MMM().format(item.createdAt),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ))));
  }
}
