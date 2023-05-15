import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../widgets.dart';

class DefaultAppBar extends StatelessWidget {
  final Widget? title;
  final Widget? bottom;
  final List<Widget>? leading;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool automaticallyImplyLeading;
  final Color? color;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final double titleSpacing;
  final Widget child;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.color,
    this.backgroundColor,
    this.boxShadow,
    this.titleSpacing = 20.0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formFactor = context.formFactor;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor ?? theme.background,
        drawerEnableOpenDragGesture: false,
        drawer: const AppDrawer(),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: Builder(
          builder: (context) {
            if (formFactor == FormFactor.extraLarge) {
              return Row(
                children: [
                  const AppDrawer(),
                  Expanded(
                    child: Column(
                      children: [
                        _DefaultAppBar(
                          title: title,
                          leading: leading,
                          actions: actions,
                          bottom: bottom,
                          automaticallyImplyLeading: false,
                          color: color,
                          boxShadow: boxShadow,
                          titleSpacing: titleSpacing,
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
                    automaticallyImplyLeading: automaticallyImplyLeading,
                    color: color,
                    boxShadow: boxShadow,
                    titleSpacing: titleSpacing,
                  ),
                  Expanded(
                    child: child,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _DefaultAppBar extends StatelessWidget {
  final Widget? title;
  final Widget? bottom;
  final List<Widget>? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double titleSpacing;

  const _DefaultAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.color,
    this.boxShadow,
    this.titleSpacing = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final defaultAppBarColor = theme.isLight ? Colors.white : theme.background;

    final defaultLeadingButton = automaticallyImplyLeading
        ? IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          )
        : null;

    return BaseAppBar(
      iconTheme: IconThemeData(color: theme.isLight ? theme.neutral30 : theme.neutral90),
      backgroundColor: color ?? defaultAppBarColor,
      boxShadow: boxShadow,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      titleSpacing: titleSpacing,
      border: context.isExtraLarge || context.isLarge
          ? const Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1))
          : null,
      leading: [if (defaultLeadingButton != null) defaultLeadingButton, ...?leading],
      title: DefaultTextStyle(
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
          color: theme.isLight ? theme.neutral30 : theme.neutral90,
        ),
        child: title ?? const SizedBox.shrink(),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
