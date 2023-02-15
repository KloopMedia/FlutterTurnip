part of 'campaign_bloc.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class FetchCampaignData extends CampaignEvent {}

class OpenCampaignInfo extends CampaignEvent {}

class JoinCampaign extends CampaignEvent {}
