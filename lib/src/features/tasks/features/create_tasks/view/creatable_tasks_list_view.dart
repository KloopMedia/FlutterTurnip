import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/cards/title_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef ItemCallback = void Function(TaskStage item);
typedef RefreshCallback = void Function();

class CreatableTasksListView extends StatelessWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final List<TaskStage> items;

  const CreatableTasksListView({
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
            padding: const EdgeInsets.all(4.0),
            child: TitleCard(title: item.name, onTap: () {
              onTap(item);
            }),
          );
        },
      ),
    );
  }
}
