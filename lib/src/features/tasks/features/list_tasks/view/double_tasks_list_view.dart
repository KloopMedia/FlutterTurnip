import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/cards/id_title_card.dart';
import 'package:gigaturnip/src/widgets/cards/id_title_card_with_form.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef ItemCallback = void Function(dynamic item);
typedef RefreshCallback = void Function();

class DoubleTasksListView extends StatefulWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final List<dynamic> firstList;
  final List<dynamic> secondList;
  final String? headerOne;
  final String? headerTwo;
  final ScrollController? scrollController;
  final bool showLoader;
  final bool expand;
  final Widget? pagination;
  final Widget search;

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
    this.expand = false,
    this.pagination,
    this.search = const SliverToBoxAdapter(),
  }) : super(key: key);

  @override
  State<DoubleTasksListView> createState() => _DoubleTasksListViewState();
}

class _DoubleTasksListViewState extends State<DoubleTasksListView> {
  final IconData iconToDo = Icons.today_rounded;

  final IconData iconDone = Icons.assignment_turned_in_outlined;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh();
      },
      child: CustomScrollView(
        controller: widget.scrollController,
        slivers: [
          widget.search,
          SliverTaskListHeader(title: widget.headerOne),
          SliverTaskList(
            items: widget.firstList,
            onTap: widget.onTap,
            icon: iconToDo,
            expand: false,
          ),
          SliverTaskListHeader(title: widget.headerTwo),
          SliverTaskList(
            items: widget.secondList,
            onTap: widget.onTap,
            icon: iconDone,
            expand: widget.expand,
          ),
          if (widget.showLoader)
            const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
          if (widget.pagination != null) widget.pagination!,
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
  final bool expand;

  const SliverTaskList({
    Key? key,
    required this.items,
    required this.onTap,
    required this.icon,
    required this.expand,
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
          if (expand) {
            return IdTitleCardForm(
              id: item.id,
              title: item.name,
              icon: icon,
              task: item,
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
            reopened: item.reopened,
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
