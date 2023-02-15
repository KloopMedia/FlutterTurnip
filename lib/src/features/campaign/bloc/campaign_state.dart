part of 'campaign_bloc.dart';

abstract class CampaignState extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignUninitialized extends CampaignState {}

class CampaignFetching extends CampaignState {}

class CampaignFetchingError extends CampaignState {
  final String error;

  CampaignFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class CampaignInitialized extends CampaignState {
  final List<Campaign> data;

  CampaignInitialized(this.data);

  CampaignInitialized.clone(CampaignInitialized oldState) : this(oldState.data);

  @override
  List<Object> get props => [data];
}

class CampaignLoaded extends CampaignInitialized {
  CampaignLoaded(super.data);
}

class CampaignInfo extends CampaignInitialized {
  final Campaign campaign;

  CampaignInfo(CampaignInitialized oldState, this.campaign) : super.clone(oldState);
}
