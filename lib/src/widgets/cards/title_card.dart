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
        color: Colors.grey[300],
        child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              onTap();
            },
            child: Text(
              title,
              style: const TextStyle(fontSize: 25),
            )),
      ),
    );
  }
}
