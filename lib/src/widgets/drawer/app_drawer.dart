import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/campaign_route.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

import 'language_select.dart';
import 'theme_switch.dart';
import 'user_avatar.dart';

const drawerDecoration = BoxDecoration(
  boxShadow: Shadows.elevation3,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(16),
    bottomRight: Radius.circular(16),
  ),
);

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationRepository>().user;
    final avatar = user.photo;
    final theme = Theme.of(context).colorScheme;
    final titleTextStyle = TextStyle(
      color: theme.onSurfaceVariant,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    );
    final subtitleTextStyle = TextStyle(
      color: theme.isLight ? theme.neutral50 : theme.neutral60,
      fontSize: 14.sp,
    );
    const iconPadding = EdgeInsets.only(right: 20);
    const contentPadding = EdgeInsets.symmetric(horizontal: 24);

    return Container(
      decoration: drawerDecoration,
      child: Drawer(
        backgroundColor: theme.isLight ? Colors.white : theme.background,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                url: avatar,
                contentPadding: contentPadding,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 2),
                child: Text(
                  user.name ?? user.id,
                  style: titleTextStyle,
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                child: user.email != null
                    ? Text(
                        user.email!,
                        style: subtitleTextStyle,
                        overflow: TextOverflow.fade,
                      )
                    : null,
              ),
              LanguageSelect(
                contentPadding: contentPadding,
                style: titleTextStyle,
                iconColor: theme.primary,
                icon: const Padding(padding: iconPadding, child: Icon(Icons.language)),
              ),
              const Divider(),
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.grid_view, color: theme.primary),
                title: Text(context.loc.drawer_campaigns, style: titleTextStyle),
                onTap: () => context.goNamed(CampaignRoute.name),
              ),
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.notifications_outlined, color: theme.primary),
                title: Text(context.loc.drawer_notifications, style: titleTextStyle),
                onTap: () {},
              ),
              ThemeSwitch(
                contentPadding: contentPadding,
                iconPadding: iconPadding,
                icon: Icon(Icons.mode_night_outlined, color: theme.primary),
                title: Text(context.loc.drawer_theme, style: titleTextStyle),
              ),
              const Spacer(),
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.help_outline, color: theme.primary),
                title: Text(context.loc.drawer_help, style: titleTextStyle),
                onTap: () {},
              ),
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.logout, color: theme.primary),
                title: Text(context.loc.drawer_exit, style: titleTextStyle),
                onTap: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
