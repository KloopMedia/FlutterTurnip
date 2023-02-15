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

class CampaignLoaded extends CampaignState {
  final List<Campaign> data;

  CampaignLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class CampaignInfo extends CampaignState {}
