import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      return await gigaTurnipRepository.getUserRelevantTaskStages(
        selectedCampaign: selectedCampaign,
        forceRefresh: forceRefresh,
      );
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
    final taskStages = await fetchData(forceRefresh: true);
    emit(state.copyWith(status: TasksStatus.initialized, taskStages: taskStages));
  }

  void refresh() async {
    emit(state.copyWith(status: TasksStatus.loading));
    final taskStages = await fetchData(forceRefresh: true);
    emit(state.copyWith(status: TasksStatus.initialized, taskStages: taskStages));
  }

  Future<Task> createTask(BuildContext context, TaskStage taskStage) async {
    try {
      final task = await gigaTurnipRepository.createTask(taskStage.id);
      return task;
    } on GigaTurnipApiRequestException catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: e.message,
          taskStages: [],
        ),
      );
      rethrow;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: TasksStatus.error,
          errorMessage: 'Failed to create tasks: $e',
          taskStages: [],
        ),
      );
      rethrow;
    }
  }
}
