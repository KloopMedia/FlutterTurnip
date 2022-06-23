import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/utilities/dialogs/logout_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
      color: Colors.blue, // TODO: Replace to global theme color
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          userAvatar,
          const SizedBox(
            height: 12,
          ),
          Text(
            user.name ?? '',
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
          Text(
            user.email ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.white),
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
        final navigator = Navigator.of(context);
        return Expanded(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: DropdownButtonFormField<AppLocales>(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.language),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  value: state.appLocale,
                  onChanged: (AppLocales? locale) {
                    if (locale != null) {
                      bloc.add(AppLocaleChanged(locale));
                    }
                  },
                  items: const [
                    DropdownMenuItem<AppLocales>(
                      value: AppLocales.system,
                      child: Text('System'),
                    ),
                    DropdownMenuItem<AppLocales>(
                      value: AppLocales.english,
                      child: Text('English'),
                    ),
                    DropdownMenuItem<AppLocales>(
                      value: AppLocales.russian,
                      child: Text('Russian'),
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
                        navigator.popUntil(ModalRoute.withName('/'));
                      }
                    },
                    child: const Text('LOG OUT'),
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
