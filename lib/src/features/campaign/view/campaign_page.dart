import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../utilities/notification_services.dart';
import '../bloc/campaign_cubit.dart';
import '../widgets/available_campaign_view.dart';
import '../widgets/user_campaign_view.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gigaTurnipApiClient = context.read<api.GigaTurnipApiClient>();
    notificationServices.getDeviceToken(gigaTurnipApiClient, null);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectableCampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: 30,
            ),
          )..initialize(),
        ),
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: 30,
            ),
          )..initialize(),
        ),
      ],
      child: const CampaignView(),
    );
  }
}

class CampaignView extends StatefulWidget {
  const CampaignView({super.key});

  @override
  State<CampaignView> createState() => _CampaignViewState();
}

class _CampaignViewState extends State<CampaignView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebCampaignView();
    }

    return ScaffoldAppbar(
      title: Text(context.loc.courses),
      drawer: AppDrawer(),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<SelectableCampaignCubit>().refetch();
          context.read<UserCampaignCubit>().refetch();
        },
        child: CustomScrollView(
          slivers: [
            AvailableCampaignView(),
            UserCampaignView(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WebCampaignView extends StatelessWidget {
  const WebCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 304.0),
          child: ScaffoldAppbar(
            title: Text(context.loc.courses),
            titleSpacing: 24,
            rounded: false,
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<SelectableCampaignCubit>().refetch();
                context.read<UserCampaignCubit>().refetch();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomScrollView(
                  slivers: [
                    AvailableCampaignView(),
                    UserCampaignView(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          color: Color(0xFFFEFBD2),
          child: AppDrawer(
            backgroundColor: const Color(0xFFFAFDFD),
          ),
        ),
      ],
    );
  }
}
