part of 'campaign_detail_bloc.dart';

abstract class CampaignDetailEvent extends Equatable {
  const CampaignDetailEvent();

  @override
  List<Object> get props => [];
}

class InitializeCampaign extends CampaignDetailEvent {}

class JoinCampaign extends CampaignDetailEvent {}
