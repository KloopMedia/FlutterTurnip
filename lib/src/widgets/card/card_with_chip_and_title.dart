import 'package:flutter/material.dart';

import 'package:gigaturnip/src/theme/index.dart';

import 'index.dart';

class CardWithTitle extends StatelessWidget {
  final List<Widget> chips;
  final String imageUrl;
  final String title;
  final double elevation;
  final Widget? body;
  final Widget? bottom;
  final Size? size;
  final int flex;
  final void Function()? onTap;

  const CardWithTitle({
    Key? key,
    this.imageUrl = '',
    required this.title,
    this.chips = const [],
    this.body,
    this.bottom,
    this.onTap,
    this.elevation = 0,
    this.size,
    this.flex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: theme.isLight ? theme.neutral40 : theme.neutral90,
      overflow: TextOverflow.ellipsis,
    );

    return BaseCard(
      size: size,
      flex: flex,
      onTap: onTap,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: chips),
                    SizedBox(height: (chips.isNotEmpty) ? 20 : 10),
                    Text(title, maxLines: 2, style: titleStyle),
                  ],
                ),
              ),
              if (imageUrl.isNotEmpty)
                SizedBox(width: 54, height: 54, child: Image.network(imageUrl)),
            ],
          ),
          if (body != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: body!,
            ),
          if (flex != 0) const Spacer(),
        ],
      ),
      bottom: bottom,
    );
  }
}
