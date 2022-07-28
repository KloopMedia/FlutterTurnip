import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';

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

  const ItemCard({Key? key, required this.item, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createdAt = DateFormat('MMM d, yyyy  HH:mm').format(DateTime.parse('${item.createdAt}'));
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      color: Colors.grey[300],
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(createdAt),
        trailing: (item.importance < 3)
            ? const Icon(Icons.notification_important, color: Colors.red)
            : null,
        onTap: () {
          onTap(item);
        },
      ),
    );
  }
}
