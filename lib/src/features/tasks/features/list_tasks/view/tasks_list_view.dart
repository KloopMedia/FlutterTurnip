import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/cards/id_title_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef ItemCallback = void Function(Task item);
typedef RefreshCallback = void Function();

class TasksListView extends StatelessWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final List<Task> items;

  const TasksListView({
    Key? key,
    required this.onTap,
    required this.onRefresh,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return Padding(
              padding: const EdgeInsets.all(4),
              child: IdTitleCard(
                id: item.id,
                title: item.name,
                date: item.createdAt,
                onTap: () {
                  onTap(item);
                },
              ),
            );
          },
        ),
    );
  }
}
