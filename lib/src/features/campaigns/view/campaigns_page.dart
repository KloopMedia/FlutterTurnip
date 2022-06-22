import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/campaigns/campaigns.dart';
import 'package:gigaturnip/src/widgets/drawers/app_drawer.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CampaignsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.campaigns),
        actions: <Widget>[
<<<<<<< HEAD
          IconButton(
            key: Key(context.loc.homePage_logout_iconButton),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
=======
          Builder(builder: (context) {
            final avatar = context.read<AppBloc>().state.user!.photo;
            return IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    )
                  : const Icon(Icons.person),
            );
          })
>>>>>>> b115fdf1b50bfe865e3097a436537459f3ae0b57
        ],
      ),
      body: BlocProvider<CampaignsCubit>(
        create: (context) => CampaignsCubit(
          gigaTurnipRepository: context.read<GigaTurnipRepository>(),
          authenticationRepository: context.read<AuthenticationRepository>(),
        ),
        child: const CampaignsView(),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}
