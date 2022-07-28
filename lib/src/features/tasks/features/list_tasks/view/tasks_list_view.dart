import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/cards/id_title_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

typedef ItemCallback = void Function(Task item);
typedef RefreshCallback = void Function();

class TasksListView extends StatelessWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final Map<String, List<Task>> items;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.todo,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items['open']?.length ?? 0,
                itemBuilder: (context, index) {
                  var itemOpen = items['open'] ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: IdTitleCard(
                      id: itemOpen[index].id,
                      title: itemOpen[index].name,
                      date: itemOpen[index].createdAt,
                      onTap: () {
                        onTap(itemOpen[index]);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.done,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items['closed']?.length ?? 0,
                itemBuilder: (context, index) {
                  var itemClosed = items['closed'] ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: IdTitleCard(
                      id: itemClosed[index].id,
                      title: itemClosed[index].name,
                      date: itemClosed[index].createdAt,
                      onTap: () {
                        onTap(itemClosed[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
