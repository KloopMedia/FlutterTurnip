import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/cards/form_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

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
    this.showLoader = false, required this.onRequest,
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
          CreatableTaskList(items: creatableTasks, onTap: onCreate, icon: iconToDo),
          SliverTaskListHeader(title: context.loc.todo),
          SliverTaskList(items: openTasks, onTap: onTap, icon: iconToDo),
          SliverTaskListHeader(title: context.loc.receive),
          SliverTaskList(items: availableTasks, onTap: onRequest, icon: iconDone),
          SliverTaskListHeader(title: context.loc.done),
          SliverTaskList(items: closedTasks, onTap: onTap, icon: iconDone),
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = items[index];
          return OutlinedButton(
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
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class SliverTaskList extends StatelessWidget {
  final List<Task> items;
  final ItemCallback onTap;
  final IconData icon;

  const SliverTaskList({
    Key? key,
    required this.items,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
