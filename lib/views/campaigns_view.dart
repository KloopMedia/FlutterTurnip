import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/constants/routes.dart';
import 'package:gigaturnip/services/api/api_provider.dart';
import 'package:gigaturnip/services/auth/auth_provider.dart';
import 'package:gigaturnip/services/auth/auth_service.dart';
import 'package:gigaturnip/services/auth/bloc/auth_bloc.dart';
import 'package:gigaturnip/services/auth/bloc/auth_event.dart';

enum MenuAction { logout }

class CampaignsView extends StatelessWidget {
  const CampaignsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaigns'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
