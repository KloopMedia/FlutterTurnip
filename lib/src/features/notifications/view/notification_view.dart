import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({
    Key? key,
    required this.notification,
    required this.campaignName,
  }) : super(key: key);

  final Notifications notification;
  final String campaignName;

  @override
  Widget build(BuildContext context) {
    var createdAt = DateFormat('MMM d, yyyy  HH:mm').format(notification.createdAt);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                createdAt,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ]),
            const SizedBox(height: 16.0),
            Text(
              notification.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Divider(thickness: 2,),
            const SizedBox(height: 16.0),
            Text(
              notification.text,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
