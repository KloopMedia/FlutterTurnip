import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';
import '../cubit/notifications_cubit.dart';

typedef ItemCallback = void Function(Notifications item);
typedef RefreshCallback = void Function();

class NotificationsSliverListView extends StatelessWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final List<Notifications> items;
  final String title;

  const NotificationsSliverListView({
    Key? key,
    required this.title,
    required this.items,
    required this.onRefresh,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(title),
            pinned: true,
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = items[index];
                return ItemCard(item: item, onTap: onTap);
              },
              childCount: items.length,
            ),
          ),
        ],
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
    // final createdAt = DateFormat('MMM d, yyyy  HH:mm')
    //     .format(DateTime.parse('${item.createdAt}'));
    // return Card(
    //   elevation: 3,
    //   margin: const EdgeInsets.all(8),
    //   color: Theme.of(context).colorScheme.secondary,
    //   child: ListTile(
    //     title: Text(
    //       item.title,
    //       style: Theme.of(context).textTheme.headlineSmall,
    //     ),
    //     subtitle: Text(createdAt),
    //     trailing: (item.importance < 3)
    //         ? const Icon(Icons.notifications_active, color: Colors.red)
    //         : null,
    //     onTap: () {
    //       onTap(item);
    //     },
    //   ),
    // );
    return SizedBox(
      child: InkWell(
        onTap: () {
          onTap(item);
        },
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      minLeadingWidth: (!state.readNotifications.contains(item)) ? 15.0 : 0.0,
                      leading: (item.importance < 3 && !state.readNotifications.contains(item))
                          ? const Icon(Icons.notifications_active, color: Colors.orangeAccent)
                          : const SizedBox.shrink(),
                      visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
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
                            height: 25,
                          ),
                          Text(
                            DateFormat.Hm().add_d().add_MMM().format(item.createdAt),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ));
          }
        )
      ),
    );
  }
}
