import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:intl/intl.dart';

typedef CardCallback = void Function();

class IdTitleCard extends StatelessWidget {
  final String title;
  final String description;
  final int? id;
  final DateTime? date;
  final CardCallback onTap;
  final IconData icon;
  final bool? reopened;

  const IdTitleCard({
    Key? key,
    required this.id,
    required this.title,
    required this.onTap,
    required this.icon,
    this.date,
    this.description = "",
    this.reopened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: FittedBox(
                        child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.copyWith().secondary,
                    )),
                  ),
                  title: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(description),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: id != null,
                        child: Text(
                          '#$id',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      if (date != null)
                        Text(
                          DateFormat.Hm().add_d().add_MMM().format(date!),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      Visibility(
                        visible: reopened != null && reopened!,
                        child: Text(
                          context.loc.task_returned,
                          style: const TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            )),
      ),
    );
  }
}

/*
Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Text('#$id', style: Theme.of(context).textTheme.headlineSmall,)),
                    if (date != null) Text(DateFormat.yMd().add_jm().format(date!), style: Theme.of(context).textTheme.headlineSmall,),
                  ],
                )
              ],
            ),
*/
