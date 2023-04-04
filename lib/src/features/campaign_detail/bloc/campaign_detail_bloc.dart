import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaign_detail_event.dart';

part 'campaign_detail_state.dart';

class CampaignDetailBloc extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final int campaignId;
  final CampaignDetailRepository _repository;

  CampaignDetailBloc({
    required CampaignDetailRepository repository,
    required this.campaignId,
    Campaign? campaign,
  })  : _repository = repository,
        super(campaign != null ? CampaignLoaded(campaign) : CampaignUninitialized()) {
    on<InitializeCampaign>(_onInitializeCampaign);
    on<JoinCampaign>(_onJoinCampaign);

    add(InitializeCampaign());
  }

  Future<void> _onInitializeCampaign(
    InitializeCampaign event,
    Emitter<CampaignDetailState> emit,
  ) async {
    if (state is CampaignUninitialized) {
      emit(CampaignFetching());
      try {
        final data = await _repository.fetchData(campaignId);
        emit(CampaignLoaded(data));
      } catch (e) {
        emit(CampaignFetchingError(e.toString()));
      }
    }
  }

  Future<void> _onJoinCampaign(
    JoinCampaign event,
    Emitter<CampaignDetailState> emit,
  ) async {
    try {
      await _repository.joinCampaign(campaignId);
      emit(CampaignJoinSuccess.clone(state as CampaignInitialized));
    } catch (e, s) {
      print(e);
      print(s);
      emit(CampaignJoinError.clone(state as CampaignInitialized, e.toString()));
    }
  }
}
