import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/cards/id_title_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef ItemCallback = void Function(dynamic item);
typedef RefreshCallback = void Function();

class DoubleTasksListView extends StatelessWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final List<dynamic> firstList;
  final List<dynamic> secondList;
  final String? headerOne;
  final String? headerTwo;

  const DoubleTasksListView({
    Key? key,
    required this.onTap,
    required this.onRefresh,
    required this.firstList,
    required this.secondList,
    this.headerOne,
    this.headerTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: CustomScrollView(
        slivers: [
          SliverTaskListHeader(title: headerOne),
          SliverTaskList(items: firstList, onTap: onTap),
          SliverTaskListHeader(title: headerTwo),
          SliverTaskList(items: secondList, onTap: onTap)
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

class SliverTaskList extends StatelessWidget {
  final List items;
  final ItemCallback onTap;

  const SliverTaskList({Key? key, required this.items, required this.onTap}) : super(key: key);

  final IconData icon = Icons.account_balance_outlined;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = items[index];
          if (item is TaskStage) {
            return IdTitleCard(
              id: null,
              title: item.name,
              description: item.description,
              icon: icon,
              date: null,
              onTap: () {
                onTap(item);
              },
            );
          }
          return IdTitleCard(
            id: item.id,
            title: item.name,
            description: item.stage.description,
            icon: icon,
            date: item.createdAt,
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
