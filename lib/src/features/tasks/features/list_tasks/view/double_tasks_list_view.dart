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
  final ScrollController? scrollController;
  final bool showLoader;

  const DoubleTasksListView({
    Key? key,
    required this.onTap,
    required this.onRefresh,
    required this.firstList,
    required this.secondList,
    this.headerOne,
    this.headerTwo,
    this.scrollController,
    this.showLoader = false,
  }) : super(key: key);

  final IconData iconToDo = Icons.assignment_turned_in_outlined;
  final IconData iconDone = Icons.done;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverTaskListHeader(title: headerOne),
          SliverTaskList(items: firstList, onTap: onTap, icon: iconToDo,),
          SliverTaskListHeader(title: headerTwo),
          SliverTaskList(items: secondList, onTap: onTap, icon: iconDone,),
          if (showLoader) const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
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
