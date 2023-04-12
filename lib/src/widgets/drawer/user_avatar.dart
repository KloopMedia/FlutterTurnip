import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  final String? url;
  final EdgeInsetsGeometry? contentPadding;

  const UserAvatar({Key? key, required this.url, this.contentPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.zero,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: url != null ? NetworkImage(url!) : null,
            child: url != null ? null : const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
