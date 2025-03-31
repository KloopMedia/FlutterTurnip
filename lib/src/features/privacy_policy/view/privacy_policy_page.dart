import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/app_bar/default_app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(CampaignRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputDecoration = InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: colorScheme.isLight ? Colors.black : colorScheme.neutral60,
        ),
      ),
    );
    final lightTheme = Theme.of(context).copyWith(inputDecorationTheme: inputDecoration);
    final darkTheme = Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(
        displayColor: Colors.white,
        bodyColor: Colors.white,
      ),
      inputDecorationTheme: inputDecoration,
    );

    return Theme(
      data: colorScheme.isLight ? lightTheme : darkTheme,
      child: DefaultAppBar(
        automaticallyImplyLeading: false,
        leading: [BackButton(onPressed: () => goBack(context))],
        title: Text(context.loc.privacy_policy),
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            if (context.isSmall) {
              return const _Content();
            } else {
              return Container(
                decoration: context.isSmall || context.isMedium
                    ? null
                    : BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: Shadows.elevation3,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(
                  vertical: context.isSmall || context.isMedium ? 0 : 40,
                  horizontal: context.isSmall || context.isMedium
                      ? 0
                      : MediaQuery.of(context).size.width / 5,
                ),
                child: const _Content(),
              );
            }
          }),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontSize: 16,
      color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
    );


    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            context.loc.policyTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            context.loc.policyDate,
            style: textStyle,
          ),
          SizedBox(height: 16),
          Text(
            context.loc.policyIntro,
            style: textStyle,
          ),
          SizedBox(height: 16),
          Text(
            context.loc.definitionsTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.definitionsIntro, style: textStyle),
          Text(context.loc.definitionAdmin, style: textStyle),
          Text(context.loc.definitionMobileApp, style: textStyle),
          Text(context.loc.definitionPersonalData, style: textStyle),
          Text(context.loc.definitionDataProcessing, style: textStyle),
          Text(context.loc.definitionUser, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.generalTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.generalContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.subjectTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.subjectContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.purposeTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.purposeContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.processingTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.processingContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.obligationsTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.userObligationsTitle, style: textStyle),
          Text(context.loc.userObligationsContent, style: textStyle),
          Text(context.loc.adminObligationsTitle, style: textStyle),
          Text(context.loc.adminObligationsContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.responsibilityTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.responsibilityContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.disputesTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.disputesContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.additionalTitle,
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(context.loc.additionalContent, style: textStyle),
          SizedBox(height: 16),
          Text(
            context.loc.confirmationText,
            style: textStyle.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _TextWithBoldTitle extends StatelessWidget {
  final String title;
  final String text;

  const _TextWithBoldTitle({
    Key? key,
    required this.title,
    required this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontSize: 16,
      color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
    );

    return Text.rich(
      TextSpan(
        text: title,
        style: textStyle.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: text,
            style: textStyle.copyWith(fontWeight: FontWeight.normal),
          ),
        ]
      ),
    );
  }
}

