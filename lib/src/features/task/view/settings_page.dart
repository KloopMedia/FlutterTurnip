import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/list_tile/custom_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const leadingPadding = EdgeInsets.only(left: 24, right: 10);
    const trailingPadding = EdgeInsets.symmetric(horizontal: 10);

    final trailing = Icon(
      Icons.arrow_forward_ios,
      size: 18,
      color: Theme.of(context).colorScheme.neutral60,
    );
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.neutral30,
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
    );

    return DefaultAppBar(
      title: Text(context.loc.settings),
      child: ListView(
        children: [
          CustomListTile(
            height: 64,
            leadingPadding: leadingPadding,
            trailingPadding: trailingPadding,
            leading: Image.asset('assets/icon/chain.png', height: 24, width: 24),
            title: Text(context.loc.settings_chains, style: textStyle),
            trailing: trailing,
            onTap: () {},
          ),
          CustomListTile(
            height: 64,
            leadingPadding: leadingPadding,
            trailingPadding: trailingPadding,
            leading: Image.asset('assets/icon/chart.png', height: 24, width: 24),
            title: Text(context.loc.settings_tracks, style: textStyle),
            trailing: trailing,
            onTap: () {},
          ),
          CustomListTile(
            height: 64,
            leadingPadding: leadingPadding,
            trailingPadding: trailingPadding,
            leading: Image.asset('assets/icon/star.png', height: 24, width: 24),
            title: Text(context.loc.settings_ranks, style: textStyle),
            trailing: trailing,
            onTap: () {},
          ),
          CustomListTile(
            height: 64,
            leadingPadding: leadingPadding,
            trailingPadding: trailingPadding,
            leading: Image.asset('assets/icon/chat.png', height: 24, width: 24),
            title: Text(context.loc.settings_messages, style: textStyle),
            trailing: trailing,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
