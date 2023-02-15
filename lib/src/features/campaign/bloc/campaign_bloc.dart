import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaign_event.dart';

part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  CampaignBloc() : super(CampaignUninitialized()) {
    on<FetchCampaignData>(_onFetchCampaignData);
    on<OpenCampaignInfo>(_onOpenCampaignInfo);
    on<JoinCampaign>(_onJoinCampaign);
  }

  Future<void> _onFetchCampaignData(FetchCampaignData event, Emitter<CampaignState> emit) async {}

  Future<void> _onOpenCampaignInfo(OpenCampaignInfo event, Emitter<CampaignState> emit) async {}

  Future<void> _onJoinCampaign(JoinCampaign event, Emitter<CampaignState> emit) async {}
}
