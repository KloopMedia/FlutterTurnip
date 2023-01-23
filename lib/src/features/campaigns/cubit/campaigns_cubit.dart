import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaigns_state.dart';

class CampaignsCubit extends Cubit<CampaignsState> {
  final AuthenticationRepository authenticationRepository;
  final GigaTurnipRepository gigaTurnipRepository;

  CampaignsCubit({
    required this.gigaTurnipRepository,
    required this.authenticationRepository,
  }) : super(const CampaignsState());

  void loadCampaigns({bool forceRefresh = false}) async {
    emit(state.copyWith(status: CampaignsStatus.loading));
    try {
      final campaigns = await gigaTurnipRepository.campaign().getUserCampaigns();
      final availableCampaigns = await gigaTurnipRepository.campaign().getSelectableCampaigns();
      emit(state.copyWith(
        campaigns: campaigns,
        availableCampaigns: availableCampaigns,
        status: CampaignsStatus.initialized,
      ));
    } on GigaTurnipApiRequestException catch (e) {
      emit(state.copyWith(
        status: CampaignsStatus.error,
        errorMessage: e.message,
        campaigns: [],
        availableCampaigns: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CampaignsStatus.error,
        errorMessage: 'Failed to load campaigns',
        campaigns: [],
        availableCampaigns: [],
      ));
    }
  }

  Future<void> joinCampaign(Campaign campaign) async {
    await gigaTurnipRepository.campaign().joinCampaign(campaign.id);
  }
}
