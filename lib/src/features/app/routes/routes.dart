import 'package:flutter/widgets.dart';
import 'package:gigaturnip/src/features/app/bloc/app_bloc.dart';
import 'package:gigaturnip/src/features/authentication/authentication.dart';
import 'package:gigaturnip/src/features/campaigns/view/campaigns_page.dart';
import 'package:gigaturnip/src/features/home/home.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [CampaignsPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}