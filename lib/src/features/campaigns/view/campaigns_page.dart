import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/campaigns/campaigns.dart';
import 'package:gigaturnip/src/widgets/drawers/app_drawer.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class CampaignsPage extends StatelessWidget {
  final bool simpleViewMode;

  const CampaignsPage({Key? key, this.simpleViewMode = false}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CampaignsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.loc.campaigns,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: <Widget>[
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
        ],
      ),
      body: BlocProvider<CampaignsCubit>(
        create: (context) => CampaignsCubit(
          gigaTurnipRepository: context.read<GigaTurnipRepository>().campaign(),
          authenticationRepository: context.read<AuthenticationRepository>(),
        ),
        child: CampaignsView(simpleViewMode: simpleViewMode),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}
