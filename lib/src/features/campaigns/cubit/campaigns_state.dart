part of 'campaigns_cubit.dart';

enum CampaignsStatus {
  uninitialized,
  loading,
  initialized,
  error,
}

class CampaignsState extends Equatable {
  final List<Campaign> campaigns;
  final List<Campaign> availableCampaigns;
  final CampaignsStatus status;
  final String? errorMessage;

  const CampaignsState({
    this.campaigns = const [],
    this.status = CampaignsStatus.uninitialized,
    this.errorMessage,
    this.availableCampaigns = const [],
  });

  CampaignsState copyWith({
    List<Campaign>? campaigns,
    CampaignsStatus? status,
    String? errorMessage,
    List<Campaign>? availableCampaigns,
  }) {
    return CampaignsState(
      campaigns: campaigns ?? this.campaigns,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      availableCampaigns: availableCampaigns ?? this.availableCampaigns,
    );
  }

  @override
  List<Object?> get props => [campaigns, status];
}
