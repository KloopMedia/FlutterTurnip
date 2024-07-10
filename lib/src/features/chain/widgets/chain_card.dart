import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class ChainCard extends StatelessWidget {
  final String title;
  final String? description;
  final void Function() onTap;

  const ChainCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    const shadows = [
      BoxShadow(
        color: Color(0x19454545),
        blurRadius: 3,
        offset: Offset(0, 1),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x19454545),
        blurRadius: 8,
        offset: Offset(0, 4),
        spreadRadius: 3,
      )
    ];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 380,
        height: 111,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: shadows,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.neutral40,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Text(
                description ?? "",
                style: TextStyle(
                  color: theme.onSurfaceVariant,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
