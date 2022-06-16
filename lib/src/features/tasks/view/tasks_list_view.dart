import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef TaskItemCallback = void Function(Task task);
typedef TasksRefreshCallback = void Function();

class TasksListView extends StatelessWidget {
  final List<Task> tasks;
  final TaskItemCallback onTap;
  final TasksRefreshCallback onRefresh;

  const TasksListView({
    Key? key,
    required this.tasks,
    required this.onTap,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var task = tasks[index];
          return ListTile(
            title: Text(
              task.name,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              onTap(task);
            },
          );
        },
      ),
    );
  }
}
