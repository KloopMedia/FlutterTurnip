part of 'campaign_detail_bloc.dart';

abstract class CampaignDetailState extends Equatable {
  const CampaignDetailState();

  @override
  List<Object> get props => [];
}

class CampaignUninitialized extends CampaignDetailState {}

class CampaignFetching extends CampaignDetailState {}

class CampaignFetchingError extends CampaignDetailState {
  final String error;

  const CampaignFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class CampaignInitialized extends CampaignDetailState {
  final Campaign data;

  const CampaignInitialized(this.data);

  CampaignInitialized.clone(CampaignInitialized state) : this(state.data);

  @override
  List<Object> get props => [data];
}

class CampaignLoaded extends CampaignInitialized {
  const CampaignLoaded(super.data);

  CampaignLoaded.clone(CampaignInitialized state) : super.clone(state);
}

class CampaignJoinSuccess extends CampaignInitialized {
  const CampaignJoinSuccess(super.data);

  CampaignJoinSuccess.clone(CampaignInitialized state) : super.clone(state);

  @override
  List<Object> get props => [];
}

class CampaignJoinError extends CampaignInitialized {
  final String error;

  const CampaignJoinError(super.data, this.error);

  CampaignJoinError.clone(CampaignInitialized state, this.error) : super.clone(state);

  @override
  List<Object> get props => [error];
}
