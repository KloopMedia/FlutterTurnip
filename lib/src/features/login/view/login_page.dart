import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/login/view/onboarding_view.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../campaign/bloc/campaign_cubit.dart';
import '../../campaign/bloc/country_bloc/country_cubit.dart';
import '../../campaign/bloc/language_bloc/language_cubit.dart';
import '../../campaign_detail/bloc/campaign_detail_bloc.dart';
import '../bloc/login_bloc.dart';
import 'login_view.dart';

/// The login page sets up the necessary blocs and shows [LoginView].
/// Depending on whether a campaign ID is provided, it may initialize a [CampaignDetailBloc].
class LoginPage extends StatelessWidget {
  final int? campaignId;

  const LoginPage({Key? key, this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(
            sharedPreferences: context.read<SharedPreferences>(),
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
        BlocProvider<CampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              limit: 10,
            ),
            context.read<SharedPreferences>(),
          )..initialize(),
        ),
        if (campaignId != null)
          BlocProvider(
            create: (context) => CampaignDetailBloc(
              repository: CampaignDetailRepository(
                gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              ),
              campaignId: campaignId!,
            )..add(InitializeCampaign()),
          ),
        BlocProvider(
          create: (context) => LanguageCubit(
            LanguageRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CountryCubit(
            CountryRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            ),
            context.read<GigaTurnipApiClient>(),
          )..initialize(),
        ),
      ],
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            return OnBoardingView();
          }
          return LoginView(campaignId: campaignId);
        },
      ),
    );
  }
}
