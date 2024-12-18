import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/privacy_policy_route.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!kIsWeb)
          Text(
            context.loc.privacy_policy_acceptance_1,
            style: TextStyle(
              color: fontColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (kIsWeb)
              Text(
                context.loc.privacy_policy_acceptance_1,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                context.goNamed(PrivacyPolicyRoute.name);
              },
              child: Text(
                context.loc.privacy_policy_acceptance_2,
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              context.loc.privacy_policy_acceptance_3,
              style: TextStyle(
                color: fontColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
