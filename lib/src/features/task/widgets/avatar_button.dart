import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

class AvatarButton extends StatelessWidget {
  final String url;
  final String text;

  const AvatarButton({
    Key? key,
    required this.url,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 150.0,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: theme.neutral90,
                    blurRadius: 2.0,
                    offset: const Offset(0, 2))
              ],
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage('https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/77/29/8a/77298a50-f7d9-07a4-9c17-d55b57a1e812/logo_gsa_ios_color-0-1x_U007emarketing-0-0-0-6-0-0-0-85-220-0.png/246x0w.webp'),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Изучение звуков в английском языке',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: theme.neutral30
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}