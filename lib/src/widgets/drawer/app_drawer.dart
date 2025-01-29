import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../router/routes/routes.dart';
import 'language_select.dart';
import 'user_avatar.dart';

const drawerDecoration = BoxDecoration(
  boxShadow: Shadows.elevation2,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(16),
    bottomRight: Radius.circular(16),
  ),
);

class AppDrawer extends StatelessWidget {
  final Color? backgroundColor;

  const AppDrawer({
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = (context.read<AuthenticationRepository>().user != User.empty);
    final user = context.read<AuthenticationRepository>().user;
    final avatar = user.photo;
    final theme = Theme.of(context).colorScheme;
    final titleTextStyle = TextStyle(
      color: theme.onSurfaceVariant,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    final subtitleTextStyle = TextStyle(
      color: theme.isLight ? theme.neutral50 : theme.neutral60,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    const iconPadding = EdgeInsets.only(right: 20);
    const contentPadding = EdgeInsets.symmetric(horizontal: 24);

    return Container(
      decoration: drawerDecoration,
      child: Drawer(
        backgroundColor: backgroundColor ?? (theme.isLight ? Colors.white : theme.background),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            UserAvatar(
              url: avatar,
              contentPadding: contentPadding,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 2),
              child: SelectableText(
                user.name ?? user.id,
                style: titleTextStyle,
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
            if (isAuthenticated)
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.grid_view, color: theme.primary),
                title: Text(context.loc.courses, style: titleTextStyle),
                onTap: () => context.pushNamed(CampaignRoute.name, extra: true),
              ),
            // CustomListTile(
            //   contentPadding: contentPadding,
            //   leadingPadding: iconPadding,
            //   leading: Icon(Icons.notifications_outlined, color: theme.primary),
            //   title: Text(context.loc.drawer_notifications, style: titleTextStyle),
            //   onTap: () {},
            // ),
            // ThemeSwitch(
            //   contentPadding: contentPadding,
            //   iconPadding: iconPadding,
            //   icon: Icon(Icons.mode_night_outlined, color: theme.primary),
            //   title: Text(context.loc.drawer_theme, style: titleTextStyle),
            // ),
            if (isAuthenticated)
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.privacy_tip_outlined, color: theme.primary),
                title: Text(context.loc.privacy_policy, style: titleTextStyle),
                onTap: () => context.pushNamed(PrivacyPolicyRoute.name),
              ),
            const Spacer(),
            // CustomListTile(
            //   contentPadding: contentPadding,
            //   leadingPadding: iconPadding,
            //   leading: Icon(Icons.help_outline, color: theme.primary),
            //   title: Text(context.loc.drawer_help, style: titleTextStyle),
            //   onTap: () {},
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 12),
              child: SelectableText(
                context.loc.call_us_title,
                style: titleTextStyle,
              ),
            ),
            CustomListTile(
              height: 24,
              contentPadding: contentPadding,
              leadingPadding: iconPadding,
              leading: Image.asset(
                'assets/icon/whatsapp.png',
                width: 24,
                height: 24,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF25D366),
                size: 12,
              ),
              title: Text(
                context.loc.call_us_whatsapp,
                style: titleTextStyle.copyWith(color: Color(0xFF25D366)),
              ),
              onTap: () {
                launchUrl(Uri.parse('https://wa.me/996220035226'));
              },
            ),
            SizedBox(height: 24),
            CustomListTile(
              height: 24,
              contentPadding: contentPadding,
              leadingPadding: iconPadding,
              leading: Image.asset(
                'assets/icon/telegram.png',
                width: 24,
                height: 24,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF4F9CE1),
                size: 12,
              ),
              title: Text(
                context.loc.call_us_telegram,
                style: titleTextStyle.copyWith(color: Color(0xFF4F9CE1)),
              ),
              onTap: () {
                launchUrl(Uri.parse('https://t.me/+996220035226'));
              },
            ),
            SizedBox(height: 24),
            if (isAuthenticated)
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.logout, color: theme.primary),
                title: Text(context.loc.drawer_exit, style: titleTextStyle),
                onTap: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
              ),
            if (isAuthenticated)
              CustomListTile(
                contentPadding: contentPadding,
                leadingPadding: iconPadding,
                leading: Icon(Icons.remove_circle_outline, color: theme.error),
                title: Text(
                  context.loc.delete_account_button,
                  style: titleTextStyle.copyWith(color: theme.error),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const DeleteAccountDialog();
                    },
                  );
                },
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
