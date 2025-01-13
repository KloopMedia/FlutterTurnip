import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            context.read<SharedPreferences>(),
          )..initialize(),
        ),
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: 30,
            ),
            context.read<SharedPreferences>(),
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
  late SharedPreferences sharedPreferences;
  List<String>? selectedCountry = [];
  bool isDialogShown = false;
  bool showFilters = false;
  List<dynamic> queries = [];
  Map<String, dynamic> queryMap = {};

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        titleSpacing: 0,
        leadingWidth: 64,
        centerTitle: false,
        title: Text(context.loc.courses),
      ),
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: [
          AvailableCampaignView(),
          UserCampaignView(),
        ],
      ),
    );
  }
}


