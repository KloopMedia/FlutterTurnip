import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/bloc/theme_bloc/theme_cubit.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';

class CampaignDrawer extends StatelessWidget {
  const CampaignDrawer({Key? key}) : super(key: key);

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

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            _Avatar(
              url: avatar,
              contentPadding: contentPadding,
            ),
            ListTile(
              contentPadding: contentPadding,
              title: Text(user.name ?? user.id, style: titleTextStyle),
              subtitle: user.email != null ? Text(user.email!, style: subtitleTextStyle) : null,
            ),
            _LanguageSelect(
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
              title: Text('Кампании', style: titleTextStyle),
              onTap: () {},
            ),
            CustomListTile(
              contentPadding: contentPadding,
              leadingPadding: iconPadding,
              leading: Icon(Icons.notifications_outlined, color: theme.primary),
              title: Text('Уведомления', style: titleTextStyle),
              onTap: () {},
            ),
            _ThemeSwitcher(
              contentPadding: contentPadding,
              iconPadding: iconPadding,
              icon: Icon(Icons.mode_night_outlined, color: theme.primary),
              title: Text('Темная тема', style: titleTextStyle),
            ),
            const Spacer(),
            CustomListTile(
              contentPadding: contentPadding,
              leadingPadding: iconPadding,
              leading: Icon(Icons.help_outline, color: theme.primary),
              title: Text('Получить помощь', style: titleTextStyle),
              onTap: () {},
            ),
            CustomListTile(
              contentPadding: contentPadding,
              leadingPadding: iconPadding,
              leading: Icon(Icons.logout, color: theme.primary),
              title: Text('Выход', style: titleTextStyle),
              onTap: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  final Text? title;
  final Icon? icon;
  final EdgeInsets? iconPadding;
  final EdgeInsetsGeometry? contentPadding;

  const _ThemeSwitcher({
    Key? key,
    this.title,
    this.iconPadding,
    this.icon,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: contentPadding ?? EdgeInsets.zero,
          child: CustomSwitchListTile(
            cupertinoVariant: true,
            leadingPadding: iconPadding,
            leading: icon,
            title: title,
            value: state.isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().switchTheme(value);
            },
          ),
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? url;
  final EdgeInsetsGeometry? contentPadding;

  const _Avatar({Key? key, required this.url, this.contentPadding}) : super(key: key);

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

class _LanguageSelect extends StatelessWidget {
  final Widget? icon;
  final Color? iconColor;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;

  const _LanguageSelect({
    Key? key,
    this.icon,
    this.style,
    this.iconColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.zero,
      child: DropdownButtonFormField<String>(
        style: style,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(minWidth: 20, maxHeight: 48),
          prefixIcon: icon,
          prefixIconColor: iconColor,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        isExpanded: true,
        isDense: true,
        icon: Icon(Icons.keyboard_arrow_down, color: iconColor),
        value: context.read<LocalizationBloc>().state.locale.languageCode.split('_').first,
        onChanged: (locale) {
          if (locale != null) {
            context.read<LocalizationBloc>().add(ChangeLocale(Locale(locale)));
          }
        },
        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'ky',
            child: Text('Кыргыз тили'),
          ),
          DropdownMenuItem(
            value: 'ru',
            child: Text('Русский'),
          ),
        ],
      ),
    );
  }
}
