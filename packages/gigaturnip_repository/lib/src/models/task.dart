import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final int id;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool reopened;
  final Stage stage;

  const Task({
    required this.id,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  @override
  List<Object?> get props => [id, responses, complete, reopened, stage];
}
