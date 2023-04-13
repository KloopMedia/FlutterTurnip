import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebMenuBar extends StatelessWidget {
  const WebMenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildBody(context),
      ],
    );
  }
  Widget buildBody(BuildContext context) {
    const avatar = null;
    final Widget userAvatar;
    if (avatar != null) {
      userAvatar = CircleAvatar(
        radius: 30.r,
        backgroundImage: NetworkImage(avatar),
      );
    } else {
      userAvatar = CircleAvatar(
        radius: 30.r,
        child: Icon(
          Icons.person,
          size: 24.sp,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 30.h),
          child: userAvatar,
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 10.h),
          child: Text(
            'Willy Wonka',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 5.h),
          child: Text(
            'willy.wonka@gmail.com',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF747878), /// neutral50
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 10.h, bottom: 5.h),
          child: const WebMenuBarLanguageButton(),
        ),
        Container(height: 0.1.h, color: Theme.of(context).colorScheme.onPrimaryContainer),
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 20.h),
          child: const WebMenuBarCompanyButton(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 40.h, right: 24.h),
          child: const WebMenuBarNotificationsButton(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h, top: 30.h, right: 12.h),
          child: const WebMenuBarThemeSwitch(),
        ),
      ],
    );
  }
}

class WebMenuBarIcon extends StatelessWidget {
  final IconData icon;
  final double? size;

  const WebMenuBarIcon({
    Key? key,
    required this.icon,
    this.size,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 27.sp,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

class WebMenuBarLanguageButton extends StatelessWidget {
  const WebMenuBarLanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const WebMenuBarIcon(icon: Icons.language),
        SizedBox(
          width: 12.h,
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12.h, 0.h, 27.h, 0.h),
                filled: false,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                )
            ),
            hint: Text(
              'Русский',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF5E81FB)),
            onChanged: (String? value) {
              print('Button pressed ...');
            },
            borderRadius: BorderRadius.circular(15.r),
            items: <String>['One', 'Two'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class WebMenuBarCompanyButton extends StatelessWidget {
  const WebMenuBarCompanyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const WebMenuBarIcon(icon: Icons.window_outlined),
        SizedBox(
          width: 15.h,
        ),
        TextButton(
          onPressed: () {
            print('Button pressed...');
          },
          child: Text(
              'Кампании',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
              )
          ),
        )
      ],
    );
  }
}

class WebMenuBarNotificationsButton extends StatelessWidget {
  const WebMenuBarNotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const WebMenuBarIcon(icon: Icons.notifications_outlined),
            SizedBox(
              width: 15.h,
            ),
            TextButton(
              onPressed: () {
                print('Button pressed...');
              },
              child: Text(
                  'Уведомления',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                  )
              ),
            ),
          ],
        ),
        Container(
            width: 24.h,
            height: 24.h,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.tertiary
            ),
            child: Center(
              child: Text(
                  '1',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.onPrimary)
              ),
            )
        ),
      ],
    );
  }
}

class WebMenuBarThemeSwitch extends StatefulWidget {
  const WebMenuBarThemeSwitch({Key? key}) : super(key: key);

  @override
  State<WebMenuBarThemeSwitch> createState() => _WebMenuBarThemeSwitchState();
}

class _WebMenuBarThemeSwitchState extends State<WebMenuBarThemeSwitch> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                const WebMenuBarIcon(icon: Icons.bedtime_outlined),
                WebMenuBarIcon(icon: Icons.star_border_outlined, size: 15.sp),
              ],
            ),
            SizedBox(
              width: 12.h,
            ),
            Text(
                'Темная тема',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                )
            ),
          ],
        ),
        Switch.adaptive(
          activeColor: Theme.of(context).colorScheme.onPrimary,
          activeTrackColor: Theme.of(context).colorScheme.primary,
          value: value,
          onChanged: (bool newValue) {
            setState(() {
              value = newValue;
            });
            print('Switch button pressed...');
          },
        )
      ],
    );
  }
}


