import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaigns_state.dart';

class CampaignsCubit extends Cubit<CampaignsState> {
  final AuthenticationRepository authenticationRepository;
  final GigaTurnipRepository gigaTurnipRepository;

  CampaignsCubit({
    required this.gigaTurnipRepository,
    required this.authenticationRepository,
  }) : super(const CampaignsState());

  void loadCampaigns() async {
    print('loading campaigns');
    emit(state.copyWith(status: CampaignsStatus.loading));
    try {
      final campaigns = await gigaTurnipRepository.getCampaigns();
      final tasks = await gigaTurnipRepository.getTasks();
      print(tasks);
      emit(state.copyWith(campaigns: campaigns, status: CampaignsStatus.initialized));
    } catch (e) {
      print('sdfsdf $e');
      emit(state.copyWith(
        status: CampaignsStatus.error,
        errorMessage: 'Failed to load campaigns',
        campaigns: [],
      ));
    }
  }
}
