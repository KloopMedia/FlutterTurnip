import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef CardCallback = void Function();

class IdTitleCard extends StatelessWidget {
  final String title;
  final int id;
  final DateTime? date;
  final CardCallback onTap;

  const IdTitleCard({
    Key? key,
    required this.id,
    required this.title,
    required this.onTap,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        color: Colors.grey[300],
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Text('#$id')),
                    if (date != null) Text(DateFormat.yMd().add_jm().format(date!)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
