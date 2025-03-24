import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/campaign_route.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';


class PushNotificationPage extends StatelessWidget {
  final RemoteNotification? notification;

  const PushNotificationPage({super.key, required this.notification});

  void redirectToNotificationPage(BuildContext context) {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(CampaignRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => redirectToNotificationPage(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            child: SizedBox(
              width: context.isSmall || context.isMedium
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    if (notification == null) {
                      return Text(context.loc.unknown_page);
                    }

                    return Column(
                      children: [
                        Text(
                          notification!.title ?? "",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Linkify(
                          text: notification!.body ?? "",
                          textAlign: TextAlign.center,
                          onOpen: (link) async {
                            if (!await launchUrl(Uri.parse(link.url))) {
                              throw Exception('Could not launch ${link.url}');
                            }
                          },
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
