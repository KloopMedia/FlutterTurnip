import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final AuthenticationRepository authenticationRepository;
  final GigaTurnipRepository gigaTurnipRepository;

  TasksCubit({
    required this.gigaTurnipRepository,
    required this.authenticationRepository,
  }) : super(const TasksState());

  void loadTasks() async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      final tasks = await gigaTurnipRepository.getTasks();
      emit(state.copyWith(tasks: tasks, status: TasksStatus.initialized));
    } on GigaTurnipApiRequestException catch (e) {
      emit(state.copyWith(
        status: TasksStatus.error,
        errorMessage: e.message,
        tasks: [],
      ));
    }
    catch (e) {
      print(e);
      emit(state.copyWith(
        status: TasksStatus.error,
        errorMessage: 'Failed to load tasks',
        tasks: [],
      ));
    }
  }

}
