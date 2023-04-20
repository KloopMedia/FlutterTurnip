import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';


class UserCampaignView extends StatelessWidget {
  const UserCampaignView({Key? key}) : super(key: key);

  void redirectToTaskMenu(BuildContext context, int id) {
    context.goNamed(
      TaskRoute.name,
      params: {'cid': '$id'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final formFactor = context.formFactor;
    final theme = Theme.of(context).colorScheme;

    if (formFactor == FormFactor.desktop || formFactor == FormFactor.tablet) {
      return SliverGridViewWithPagination<Campaign, UserCampaignCubit>(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        crossAxisCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
          childAspectRatio: 1.65
        ),
        itemBuilder: (context, index, item) {
          return CardWithChipAndTitle(
            tag: 'Placeholder',
            title: item.name,
            size: const Size.fromHeight(250),
            color: theme.isLight ? Colors.white : theme.onSecondary,
            imageUrl: item.logo,
            flex: 1,
            onTap: () => redirectToTaskMenu(context, item.id),
            body: item.unreadNotifications > -1
                ? CardMessage('У вас ${item.unreadNotifications} непрочитанное сообщение')
                : null,
            bottom: const _CampaignProgress(),
          );
        },
      );
    } else {
      return SliverListViewWithPagination<Campaign, UserCampaignCubit>(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index, item) {
          return CardWithChipAndTitle(
            tag: 'Placeholder',
            title: item.name,
            color: theme.isLight ? Colors.white : theme.onSecondary,
            imageUrl: item.logo,
            onTap: () => redirectToTaskMenu(context, item.id),
            body: item.unreadNotifications > 0
                ? CardMessage('У вас ${item.unreadNotifications} непрочитанное сообщение')
                : null,
            bottom: const _CampaignProgress(),
          );
        },
      );
    }
  }
}


class _CampaignProgress extends StatelessWidget {
  final EdgeInsetsGeometry? _padding;

  const _CampaignProgress({Key? key, EdgeInsetsGeometry? padding})
      : _padding = padding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: _padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Осталось 4 задания до следующего уровня!',
            style: TextStyle(fontSize: 14.sp, color: theme.onSurfaceVariant),
          ),
          Row(
            children: const [
              Icon(Icons.looks_one, color: Color(0xffDFC902)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: LinearProgressIndicator(
                      value: 3,
                      minHeight: 6,
                    ),
                  ),
                ),
              ),
              Icon(Icons.looks_two, color: Color(0xffDFC902)),
            ],
          ),
        ],
      ),
    );
  }
}