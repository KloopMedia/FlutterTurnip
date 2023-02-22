part of 'campaign_bloc.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class FetchCampaignData extends CampaignEvent {
  final int page;

  const FetchCampaignData(this.page);
}

class OpenCampaignInfo extends CampaignEvent {
  final Campaign campaign;

  const OpenCampaignInfo(this.campaign);
}

class JoinCampaign extends CampaignEvent {}
