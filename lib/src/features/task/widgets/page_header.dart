import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../campaign_detail/bloc/campaign_detail_bloc.dart';

class PageHeader extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const PageHeader({Key? key, this.padding = EdgeInsets.zero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final appBarColor = theme.isLight
        ? const Color.fromRGBO(241, 243, 255, 1)
        : const Color.fromRGBO(40, 41, 49, 1);

    if (context.isMobile) {
      return Stack(children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: appBarColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: theme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        const _Content(padding: EdgeInsets.only(top: 30, bottom: 20)),
      ]);
    }

    return _Content(padding: padding);
  }
}

class _Content extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const _Content({Key? key, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
              builder: (context, state) {
                // TODO: Replace placeholder
                const placeholder =
                    'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1';
                if (state is CampaignLoaded && state.data.logo.isNotEmpty) {
                  return Image.network(state.data.logo, width: 100, height: 100);
                } else {
                  return Image.network(placeholder, width: 100, height: 100);
                }
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Уровень: Продвинутый',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: theme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
