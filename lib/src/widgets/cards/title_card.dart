import 'package:flutter/material.dart';

typedef CardCallback = void Function();

class TitleCard extends StatelessWidget {
  final String title;
  final CardCallback onTap;

  const TitleCard({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        color: Theme.of(context).colorScheme.copyWith().secondary,
        child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              onTap();
            },
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,

            )),
      ),
    );
  }
}
