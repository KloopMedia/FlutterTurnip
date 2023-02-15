import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaign_event.dart';

part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final GigaTurnipRepository _gigaTurnipRepository;

  CampaignBloc(this._gigaTurnipRepository) : super(CampaignUninitialized()) {
    on<FetchCampaignData>(_onFetchCampaignData);
    on<OpenCampaignInfo>(_onOpenCampaignInfo);
    on<JoinCampaign>(_onJoinCampaign);
    add(FetchCampaignData());
  }

  Future<void> _onFetchCampaignData(FetchCampaignData event, Emitter<CampaignState> emit) async {
    try {
      emit(CampaignFetching());
      final data = await _fetchData();
      emit(CampaignLoaded(data));
    } on Exception catch (e) {
      print(e);
      emit(CampaignFetchingError(e.toString()));
      emit(state);
    }
  }

  Future<void> _onOpenCampaignInfo(OpenCampaignInfo event, Emitter<CampaignState> emit) async {
    emit(CampaignInfo(state as CampaignInitialized, event.campaign));
  }

  Future<void> _onJoinCampaign(JoinCampaign event, Emitter<CampaignState> emit) async {}

  Future<List<Campaign>> _fetchData() async {
    final userCampaigns = await _gigaTurnipRepository.campaign().getUserCampaigns();
    final selectableCampaigns = await _gigaTurnipRepository.campaign().getSelectableCampaigns();
    return [...userCampaigns, ...selectableCampaigns];
  }
}
