part of 'campaigns_cubit.dart';

enum CampaignsStatus {
  uninitialized,
  loading,
  initialized,
  error,
}

class CampaignsState extends Equatable {
  final List<Campaign> campaigns;
  final CampaignsStatus status;
  final String? errorMessage;

  const CampaignsState({
    this.campaigns = const [],
    this.status = CampaignsStatus.uninitialized,
    this.errorMessage,
  });

  CampaignsState copyWith({
    List<Campaign>? campaigns,
    CampaignsStatus? status,
    String? errorMessage,
  }) {
    return CampaignsState(
      campaigns: campaigns ?? this.campaigns,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [campaigns, status];
}
