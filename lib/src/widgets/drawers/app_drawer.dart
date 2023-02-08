import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/utilities/dialogs/logout_dialog.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildBody(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final user = context.read<AppBloc>().state.user!;
    final avatar = user.photo;

    final Widget userAvatar;
    if (avatar != null) {
      userAvatar = CircleAvatar(
        radius: 52,
        backgroundImage: NetworkImage(avatar),
      );
    } else {
      userAvatar = const CircleAvatar(
        radius: 52,
        child: Icon(
          Icons.person,
          size: 52,
        ),
      );
    }

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

  Widget buildBody(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final bloc = context.read<AppBloc>();
        return Expanded(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField<AppLocales>(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.language),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        value: bloc.sharedPrefsAppLocale ?? state.appLocale ?? AppLocales.kyrgyz,
                        onChanged: (AppLocales? locale) {
                          if (locale != null) {
                            bloc.add(AppLocaleChanged(locale));

                          }
                        },
                        items: [
                          // DropdownMenuItem<AppLocales>(
                          //     value: AppLocales.system,
                          //     child: Text(
                          //       context.loc.language,
                          //       style: Theme.of(context).textTheme.titleSmall,
                          //     )),
                          DropdownMenuItem<AppLocales>(
                            value: AppLocales.english,
                            child: Text(
                              context.loc.english,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          DropdownMenuItem<AppLocales>(
                            value: AppLocales.russian,
                            child: Text(
                              context.loc.russian,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          DropdownMenuItem<AppLocales>(
                            value: AppLocales.kyrgyz,
                            child: Text(
                              context.loc.kyrgyz,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
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
                      final shouldLogout = await showLogOutDialog(context);
                      if (shouldLogout) {
                        bloc.add(AppLogoutRequested());
                      }
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
      },
    );
  }
}
