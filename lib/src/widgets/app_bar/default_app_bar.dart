import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../widgets.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final Widget? bottom;
  final List<Widget>? leading;
  final List<Widget>? actions;
  final Widget child;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formFactor = context.formFactor;

    return Scaffold(
      backgroundColor: theme.background,
      drawerEnableOpenDragGesture: false,
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) {
          if (formFactor == FormFactor.desktop) {
            return Row(
              children: [
                const AppDrawer(),
                Expanded(
                  child: Column(
                    children: [
                      _DefaultAppBar(
                        title: title,
                        leading: const [],
                        actions: actions,
                        bottom: bottom,
                      ),
                      Expanded(
                        child: child,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _DefaultAppBar(
                  title: title,
                  leading: leading,
                  actions: actions,
                  bottom: bottom,
                ),
                Expanded(
                  child: child,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _DefaultAppBar extends StatelessWidget {
  final String title;
  final Widget? bottom;
  final List<Widget>? leading;
  final List<Widget>? actions;

  const _DefaultAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BaseAppBar(
      iconTheme: IconThemeData(color: theme.isLight ? theme.neutral30 : theme.neutral90),
      backgroundColor: theme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      titleSpacing: context.formFactor == FormFactor.mobile ? 23 : 17,
      border: const Border(
        bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
      ),
      leading: leading ??
          [
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ],
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
          color: theme.isLight ? theme.neutral30 : theme.neutral90,
        ),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
