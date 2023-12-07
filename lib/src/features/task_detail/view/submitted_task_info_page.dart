import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmittedTaskInfoPage extends StatelessWidget {
  const SubmittedTaskInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 37, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage('assets/images/email_plane.png'),
              width: 163,
              height: 100
            ),
            const SizedBox(height: 24),
            Text(
              'Сообщение отправлено, с Вами свяжутся в ближайшее время!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: theme.neutral40
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Если Вы хотите следить за каждым этапом работы с вашим сообщением, скачайте приложение в Play Market или воспользуйтесь ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40
                    ),
                  ),
                  TextSpan(
                    text: 'веб-версией',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: theme.primary
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () async {
                      final url = Uri.parse('https://kloopmedia/github.io/FlutterTurnip/#/');
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              child: const Image(
                image: AssetImage('assets/images/google_play_badge.png'),
                width: 171,
                height: 52
              ),
              onTap: () async {
                final url = Uri.parse('https://play.google.com/store/search?q=giga+turnip&c=apps');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
