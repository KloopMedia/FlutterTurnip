import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/chain/bloc/chain_cubit.dart';
import 'package:gigaturnip/src/features/chain/widgets/chain_card.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../router/routes/routes.dart';

class CampaignManagementPage extends StatefulWidget {
  const CampaignManagementPage({Key? key}) : super(key: key);

  @override
  State<CampaignManagementPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignManagementPage> {
  late final colorScheme = Theme.of(context).colorScheme;

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
        bottom: BaseTabBar(
          width: calculateTabWidth(context),
          border: context.formFactor == FormFactor.small
              ? Border(
                  bottom: BorderSide(
                    color: colorScheme.isLight
                        ? colorScheme.neutralVariant80
                        : colorScheme.neutralVariant40,
                    width: 2,
                  ),
                )
              : null,
          tabs: [
            Tab(
              child: Text(context.loc.chains, overflow: TextOverflow.ellipsis),
            ),
            Tab(
              child: Text("Statistics", overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        child: const TabBarView(
          children: [
            ChainView(),
            StatisticView(),
          ],
        ),
      ),
    );
  }
}

class ChainView extends StatelessWidget {
  const ChainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChainCubit(
        ChainRepository(
          campaignId: 3,
          gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
        ),
      )..initialize(),
      child: CustomScrollView(
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
      ),
    );
  }
}

class StatisticView extends StatelessWidget {
  const StatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime(2010), 35),
      SalesData(DateTime(2011), 28),
      SalesData(DateTime(2012), 34),
      SalesData(DateTime(2013), 32),
      SalesData(DateTime(2014), 40)
    ];

    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <CartesianSeries>[
              // Renders line chart
              LineSeries<SalesData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
