import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';

typedef ItemCallback = void Function(Notifications item);
typedef RefreshCallback = void Function();

class NotificationsListView extends StatelessWidget {
  final ItemCallback onTap;
  final RefreshCallback onRefresh;
  final List<Notifications> items;

  const NotificationsListView({
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
            shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            var createdAt = DateFormat('MMM d, yyyy  HH:mm').format(DateTime.parse('${item.createdAt}'));
            return Card(
                elevation: 3,
                margin: const EdgeInsets.all(8),
                color: Colors.grey[300],
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(createdAt),
                  trailing: (item.importance < 3) ? const Icon(Icons.notification_important, color: Colors.red) : null,
                  onTap: () {
                    onTap(item);
                  },
                )
            );
          },
      ),
    );
  }
}