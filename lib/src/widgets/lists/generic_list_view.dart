import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef ItemCallback<T> = void Function(T item);
typedef RefreshCallback = void Function();

class GenericListView<T> extends StatelessWidget {
  final ItemCallback<T> onTap;
  final RefreshCallback onRefresh;
  final List<T> items;

  const GenericListView({
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
          if (item is Task) {
            return ListTile(
              title: Text(
                item.name,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                onTap(item);
              },
            );
          } else if (item is Campaign) {
            return ListTile(
              title: Text(
                item.name,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                onTap(item);
              },
            );
          } else if (item is TaskStage) {
            return ListTile(
              title: Text(
                item.name,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                onTap(item);
              },
            );
          } else {
            throw Exception('Unknown class $T');
          }
        },
      ),
    );
  }
}
