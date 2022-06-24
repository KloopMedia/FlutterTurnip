import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    var state = context.read<AppBloc>().state;
    var user = state.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.home),
        actions: <Widget>[
          IconButton(
            key: Key(context.loc.homePage_logout_iconButton),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(user!.email ?? '', style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 4),
                Text(user.name ?? '', style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 4),
                Text(state.selectedCampaign?.id.toString() ?? '', style: Theme.of(context).textTheme.headline6),
              ],
            );
          },
        ),
      ),
    );
  }
}
