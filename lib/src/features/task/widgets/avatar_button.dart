import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

class AvatarButton extends StatelessWidget {
  final String url;
  final String text;
  final void Function() onTap;

  const AvatarButton({
    Key? key,
    required this.url,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 90,
              decoration: BoxDecoration(
                boxShadow: Shadows.elevation3,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(url),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: theme.neutral30),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
