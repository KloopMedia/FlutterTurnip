import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip/src/features/tasks/constants/status.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'create_tasks_state.dart';

class CreateTasksCubit extends Cubit<CreateTasksState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final Campaign selectedCampaign;

  CreateTasksCubit({
    required this.gigaTurnipRepository,
    required this.selectedCampaign,
  }) : super(const CreateTasksState());

  Future<List<TaskStage>> fetchData({bool forceRefresh = false}) async {
    try {
      return await gigaTurnipRepository.getUserRelevantTaskStages(selectedCampaign: selectedCampaign);
    } on GigaTurnipApiRequestException catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: e.message,
          taskStages: [],
        ),
      );
      rethrow;
    } catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: 'Failed to load tasks',
          taskStages: [],
        ),
      );
      rethrow;
    }
  }

  void initialize() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final taskStages = await fetchData();
    emit(state.copyWith(status: TasksStatus.initialized, taskStages: taskStages));
  }

  void refresh() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final taskStages = await fetchData(forceRefresh: true);
    emit(state.copyWith(status: TasksStatus.initialized, taskStages: taskStages));
  }
}
