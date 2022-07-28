import 'package:flutter/material.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  const NotificationView(
      {Key? key, required this.notification, required this.campaignName})
      : super(key: key);

  final Notifications notification;
  final String campaignName;

  @override
  Widget build(BuildContext context) {
    var createdAt = DateFormat('MMM d, yyyy  HH:mm')
        .format(DateTime.parse('${notification.createdAt}'));

    return Scaffold(
      appBar: AppBar(
        title: Text(notification.title),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        // Container(
        //   padding: const EdgeInsets.all(10.0),
        //   alignment: Alignment.center,
        //   color: Colors.purple[400],
        //   child: Text(campaignName, style: const TextStyle(fontSize: 18.0, color: Colors.white)),
        // ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  createdAt,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ]),
              const SizedBox(height: 16.0),
              Text(
                notification.text,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
