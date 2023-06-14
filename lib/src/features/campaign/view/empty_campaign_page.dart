import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class EmptyCampaignPage extends StatelessWidget {
  final String title;
  final String body;
  const EmptyCampaignPage({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 59.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_list.png'),
          const SizedBox(height: 30),
          Text(
            title,
            style: textTheme.headlineSmall?.copyWith(color: colorScheme.isLight ? colorScheme.neutral30 : colorScheme.neutral90),
          ),
          const SizedBox(height: 15),
          Text(
            body,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.isLight ? colorScheme.neutral40 : colorScheme.neutral80),
          )
        ],
      ),
    );
  }
}
