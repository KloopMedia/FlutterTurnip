import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:gigaturnip/src/bloc/localization_bloc/localization_bloc.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;
    final avatar = user.photo;
    late final Widget userAvatar;

    try {
      userAvatar = CircleAvatar(
        radius: 52,
        backgroundImage: NetworkImage(avatar!),
      );
    } catch (e) {
      userAvatar = const CircleAvatar(
        radius: 52,
        child: Icon(
          Icons.person,
          size: 52,
        ),
      );
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(userAvatar: userAvatar, user: user),
          DrawerBody(),
        ],
      ),
    );
  }
}

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<Locale>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.language),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    value: context.read<LocalizationBloc>().state.locale,
                    onChanged: (locale) {
                      if (locale != null) {
                        context.read<LocalizationBloc>().add(ChangeLocale(locale));
                      }
                    },
                    items: context.supportedLocales
                        .map((locale) => DropdownMenuItem<Locale>(
                              value: locale.value,
                              child: Text(locale.key),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.push('/settings');
                    },
                    child: Text(
                      context.loc.settings,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // final shouldLogout = await showLogOutDialog(context);
                  // if (shouldLogout) {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                  // }
                },
                child: Text(
                  context.loc.logout,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
    required this.userAvatar,
    required this.user,
  }) : super(key: key);

  final Widget userAvatar;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          userAvatar,
          const SizedBox(
            height: 12,
          ),
          Text(
            user.name ?? '',
            style: const TextStyle(fontSize: 28, color: Colors.black),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              user.email ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
