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
    final iconPadding = const EdgeInsets.only(right: 20);

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _Avatar(url: avatar),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(user.name ?? user.id, style: titleTextStyle),
              subtitle: user.email != null ? Text(user.email!, style: subtitleTextStyle) : null,
            ),
            _LanguageSelect(
              style: titleTextStyle,
              iconColor: theme.primary,
              icon: Padding(padding: iconPadding, child: const Icon(Icons.language)),
            ),
            CustomListTile(
              leadingPadding: iconPadding,
              leading: Icon(Icons.grid_view, color: theme.primary),
              title: Text('Кампании', style: titleTextStyle),
              onTap: () {},
            ),
            CustomListTile(
              leadingPadding: iconPadding,
              leading: Icon(Icons.notifications_outlined, color: theme.primary),
              title: Text('Уведомления', style: titleTextStyle),
              onTap: () {},
            ),
            _ThemeSwitcher(
              iconPadding: iconPadding,
              icon: Icon(Icons.mode_night_outlined, color: theme.primary),
              title: Text('Темная тема', style: titleTextStyle),
            ),
            const Spacer(),
            CustomListTile(
              leadingPadding: iconPadding,
              leading: Icon(Icons.help_outline, color: theme.primary),
              title: Text('Получить помощь', style: titleTextStyle),
              onTap: () {},
            ),
            CustomListTile(
              leadingPadding: iconPadding,
              leading: Icon(Icons.logout, color: theme.primary),
              title: Text('Выход', style: titleTextStyle),
              onTap: () {},
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

  const _ThemeSwitcher({Key? key, this.title, this.iconPadding, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return CustomSwitchListTile(
          leadingPadding: iconPadding,
          leading: icon,
          title: title,
          value: state.isDark,
          onChanged: (value) {
            context.read<ThemeCubit>().switchTheme(value);
          },
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? url;

  const _Avatar({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: url != null ? NetworkImage(url!) : null,
          child: url != null ? null : const Icon(Icons.person),
        ),
      ],
    );
  }
}

class _LanguageSelect extends StatelessWidget {
  final Widget? icon;
  final Color? iconColor;
  final TextStyle? style;

  const _LanguageSelect({Key? key, this.icon, this.style, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
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
    );
  }
}
