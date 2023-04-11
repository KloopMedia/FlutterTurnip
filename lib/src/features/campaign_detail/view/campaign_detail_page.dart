import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/shadows.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/campaign_detail_bloc.dart';

class CampaignDetailPage extends StatelessWidget {
  final int campaignId;
  final Campaign? campaign;

  const CampaignDetailPage({
    Key? key,
    required this.campaignId,
    this.campaign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignDetailBloc(
        repository: CampaignDetailRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
        ),
        campaignId: campaignId,
        campaign: campaign,
      )..add(InitializeCampaign()),
      child: const CampaignDetailView(),
    );
  }
}

class CampaignDetailView extends StatelessWidget {
  const CampaignDetailView({Key? key}) : super(key: key);

  void redirectToTaskMenu(BuildContext context, int id) {
    context.goNamed(
      TaskRoute.name,
      params: {
        'cid': "$id",
      },
    );
  }

  void redirectToCampaigns(BuildContext context) {
    context.goNamed(CampaignRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(167.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => redirectToCampaigns(context),
            color: theme.neutral40,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.w,
            ),
          ),
        ),
      ),
      body: BlocConsumer<CampaignDetailBloc, CampaignDetailState>(
        listener: (context, state) {
          if (state is CampaignJoinSuccess) {
            showDialog(context: context, builder: (context) => const _AlertDialog())
                .then((value) => redirectToTaskMenu(context, state.data.id));
          }
        },
        builder: (context, state) {
          if (state is CampaignFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CampaignFetchingError) {
            return Center(child: Text(state.error));
          }
          if (state is CampaignJoinError) {
            return Center(child: Text(state.error));
          }
          if (state is CampaignLoaded) {
            return Stack(
              children: [
                _CampaignCard(data: state.data),
                if (state.data.logo.isNotEmpty)
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 100.w,
                      width: 100.w,
                      child: Image.network(state.data.logo),
                    ),
                  ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AlertDialog(
      actionsPadding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.w),
      ),
      title: Text(
        'Вы присоединились!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF191C1B),
        ),
      ),
      content: Text(
        'Кампании к которым вы присоединились можете найти во вкладке “Мои кампании”',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 16.sp,
          color: theme.neutral40,
        ),
      ),
      actions: [
        SizedBox(
          height: 52.h,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Понятно'),
          ),
        )
      ],
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Campaign data;

  const _CampaignCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      decoration: BoxDecoration(
        boxShadow: Shadows.elevation3,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.w),
          topRight: Radius.circular(30.w),
        ),
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.w),
            topRight: Radius.circular(30.w),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Text(
                data.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.primary,
                ),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral40,
                  ),
                ),
              ),
              if (data.canJoin)
                Padding(
                  padding: EdgeInsets.only(bottom: 45.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                      ),
                      onPressed: () {
                        context.read<CampaignDetailBloc>().add(JoinCampaign());
                      },
                      child: Text(
                        context.loc.join_campaign,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
