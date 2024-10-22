import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
      builder: (context, state) {
        if (state is CampaignInitialized && state.data.contactUsLink != null) {
          return Padding(
            padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                if (!await launchUrl(Uri.parse(state.data.contactUsLink!))) {
                  print('Error launching');
                }
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFEFEFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/chat.png',
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "У вас есть вопросы?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Связаться с нами",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    Text(
                      'Напишите нам и мы обязательно свяжемся с вами',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.neutral30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
