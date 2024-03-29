part of 'campaign_cubit.dart';

class CampaignLoaded extends RemoteDataInitialized<Campaign> {
  CampaignLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    required super.query,
    required super.body,
  });
}

class CampaignInfo extends RemoteDataInitialized<Campaign> {
  final Campaign campaign;

  CampaignInfo.clone(RemoteDataInitialized<Campaign> oldState, this.campaign)
      : super.clone(oldState);
}
