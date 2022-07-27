import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef CardCallback = void Function();

class IdTitleCard extends StatelessWidget {
  final String title;
  final String description;
  final int? id;
  final DateTime? date;
  final CardCallback onTap;

  const IdTitleCard({
    Key? key,
    required this.id,
    required this.title,
    required this.onTap,
    this.date,
    this.description = "",
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
                      Icons.assignment_turned_in_outlined,
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
                    children: [
                      Visibility(
                        visible: id != null,
                        child: Text(
                          '#$id',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (date != null)
                        Text(
                          DateFormat.Hm().add_d().add_MMM().format(date!),
                          style: Theme.of(context).textTheme.caption,
                        ),
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
