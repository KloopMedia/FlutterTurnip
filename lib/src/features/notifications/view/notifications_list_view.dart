import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

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
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return Card(
              elevation: 3,
              margin: const EdgeInsets.all(8),
              color: Colors.grey[300],
              child: ListTile(
                title: Text(item.title, style: const TextStyle(fontSize: 25)),
                subtitle: Text('$item.createdAt', style: const TextStyle(fontSize: 20)),
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