import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/campaign_management/bloc/user_activity_cubit.dart';
import 'package:gigaturnip/src/features/chain/bloc/chain_cubit.dart';
import 'package:gigaturnip/src/features/chain/widgets/chain_card.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';

class CampaignManagementPage extends StatefulWidget {
  const CampaignManagementPage({Key? key}) : super(key: key);

  @override
  State<CampaignManagementPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignManagementPage> {
  late final colorScheme = Theme.of(context).colorScheme;
  late final campaignId = int.parse(GoRouterState.of(context).pathParameters['cid']!);

  @override
  void initState() {
    super.initState();
  }

  double calculateTabWidth(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    if (context.isExtraLarge) {
      return deviceWidth / 3;
    } else if (context.isLarge) {
      return deviceWidth / 2;
    } else {
      return double.infinity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: DefaultAppBar(
        title: Text(context.loc.campaigns),
        child: MultiBlocProvider(
          providers: [
            // BlocProvider(
            //   create: (context) => ChainCubit(
            //     ChainRepository(
            //       campaignId: campaignId,
            //       gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            //     ),
            //   )..initialize(),
            // ),
            BlocProvider(
              create: (context) => UserActivityCubit(
                UserActivityRepository(
                  campaignId: campaignId,
                  gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
                ),
              )..initialize(query: {'limit': 2000}),
            ),
          ],
          child: const StatisticView(),
        ),
      ),
    );
  }
}

class ChainView extends StatelessWidget {
  const ChainView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AdaptiveListView<Chain, ChainCubit>(
          padding: const EdgeInsets.all(24),
          mainAxisSpacing: 20,
          itemBuilder: (context, state, item) {
            return ChainCard(
              title: item.name,
              description: item.description,
              onTap: () {
                context.goNamed(TaskManagementRoute.name, pathParameters: {
                  ...GoRouterState.of(context).pathParameters,
                  'chainId': item.id.toString()
                });
              },
            );
          },
        )
      ],
    );
  }
}

class StatisticView extends StatelessWidget {
  const StatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserActivityCubit, RemoteDataState<UserActivity>>(
        builder: (context, state) {
          if (state is RemoteDataLoaded<UserActivity>) {
            return SelectionArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: PaginatedDataTable(
                    rowsPerPage: 10,
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Stage name')),
                      DataColumn(label: Text('Total')),
                      DataColumn(label: Text('Opened')),
                      DataColumn(label: Text('Closed')),
                    ],
                    source: TableDataSource(state.data),
                  ),
                ),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class TableDataSource extends DataTableSource {
  final List<UserActivity> data;

  TableDataSource(this.data);

  DataRow buildTableRow(UserActivity data) {
    return DataRow(
      cells: [
        DataCell(
          Text(data.stage.toString()),
        ),
        DataCell(
          Text(data.stageName.toString()),
        ),
        DataCell(
          Text(data.countTasks.toString()),
        ),
        DataCell(
          Text(data.completeFalse.toString()),
        ),
        DataCell(
          Text(data.completeTrue.toString()),
        ),
      ],
    );
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return buildTableRow(item);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
