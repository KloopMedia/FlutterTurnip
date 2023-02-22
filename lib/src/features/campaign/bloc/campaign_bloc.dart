import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaign_event.dart';

part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final UserCampaignRepository _userCampaignRepository;
  final SelectableCampaignRepository _selectableCampaignRepository;

  CampaignBloc(this._userCampaignRepository, this._selectableCampaignRepository) : super(CampaignUninitialized()) {
    on<FetchCampaignData>(_onFetchCampaignData);
    on<OpenCampaignInfo>(_onOpenCampaignInfo);
    on<JoinCampaign>(_onJoinCampaign);
    add(const FetchCampaignData(0));
  }

  Future<void> _onFetchCampaignData(FetchCampaignData event, Emitter<CampaignState> emit) async {
    final page = event.page;
    try {
      emit(CampaignFetching());
      final data = await _fetchData(page);
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

  Future<List<Campaign>> _fetchData(int page) async {
    final userCampaigns = await _userCampaignRepository.fetchDataOnPage(page);
    final selectableCampaigns = await _selectableCampaignRepository.fetchDataOnPage(page);
    return [...userCampaigns, ...selectableCampaigns];
  }
}
