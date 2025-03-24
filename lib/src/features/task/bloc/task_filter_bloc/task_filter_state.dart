part of 'task_filter_cubit.dart';

@immutable
final class TaskFilterState extends Equatable {
  final Map<String, dynamic>? taskQuery;
  final Map<String, dynamic>? chainQuery;
  final Volume? volume;

  const TaskFilterState({this.taskQuery, this.chainQuery, this.volume});

  static TaskFilterState initial() {
    return TaskFilterState(
      taskQuery: {'complete': false},
      chainQuery: {'completed': false},
    );
  }

  TaskFilterState copyWith({
    Map<String, dynamic>? taskQuery,
    Map<String, dynamic>? chainQuery,
    Volume? volume,
  }) {
    return TaskFilterState(
      taskQuery: taskQuery ?? this.taskQuery,
      chainQuery: chainQuery ?? this.chainQuery,
      volume: volume ?? this.volume,
    );
  }

  @override
  List<Object?> get props => [taskQuery.hashCode, chainQuery.hashCode, volume];
}
