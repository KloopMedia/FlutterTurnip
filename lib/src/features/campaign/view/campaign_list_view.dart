import 'package:flutter/material.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class CampaignListView<Data, Cubit extends RemoteDataCubit<Campaign>> extends StatelessWidget {
  final void Function(BuildContext context, Campaign item)? onTap;
  final Widget? Function(Campaign item)? bodyBuilder;
  final Widget? Function(Campaign item)? bottomBuilder;

  const CampaignListView({
    Key? key,
    this.onTap,
    this.bodyBuilder,
    this.bottomBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formFactor = context.formFactor;
    final theme = Theme.of(context).colorScheme;
    final color = theme.isLight ? Colors.white : theme.onSecondary;

    if (formFactor == FormFactor.desktop || formFactor == FormFactor.tablet) {
      return SliverGridViewWithPagination<Campaign, Cubit>(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        crossAxisCount: 3,
        itemBuilder: (context, index, item) {
          return CardWithChipAndTitle(
            tag: 'Placeholder',
            title: item.name,
            size: const Size.fromHeight(250),
            color: color,
            imageUrl: item.logo,
            flex: 1,
            onTap: () => onTap != null ? onTap!(context, item) : null,
            body: bodyBuilder != null ? bodyBuilder!(item) : null,
            bottom: bottomBuilder != null ? bottomBuilder!(item) : null,
          );
        },
      );
    } else {
      return SliverListViewWithPagination<Campaign, Cubit>(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index, item) {
          return CardWithChipAndTitle(
            tag: 'Placeholder',
            title: item.name,
            color: color,
            imageUrl: item.logo,
            onTap: () => onTap != null ? onTap!(context, item) : null,
            body: bodyBuilder != null ? bodyBuilder!(item) : null,
            bottom: bottomBuilder != null ? bottomBuilder!(item) : null,
          );
        },
      );
    }
  }
}
