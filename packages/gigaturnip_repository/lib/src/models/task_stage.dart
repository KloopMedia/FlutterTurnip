import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStage;
import 'package:json_annotation/json_annotation.dart';

part 'task_stage.g.dart';

enum StageType {
  /// Proactive
  pr,

  /// Reactive
  ac,

  /// ProactiveButtons
  pb,
}

StageType convertStringToStageType(String? stageType) {
  switch (stageType) {
    case 'AC':
      return StageType.ac;
    case 'PR':
      return StageType.pr;
    case 'PB':
      return StageType.pb;
    default:
      return StageType.ac;
  }
}

String convertStageTypeToString(StageType stageType) {
  return stageType.name.toUpperCase();
}

@JsonSerializable(explicitToJson: true)
class TaskStage extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final int campaign;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final DateTime? availableTo;
  final DateTime? availableFrom;
  @JsonKey(fromJson: convertStringToStageType, toJson: convertStageTypeToString)
  final StageType stageType;
  final int openLimit;
  final int totalLimit;
  final String? takeTaskButtonText;


  const TaskStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.campaign,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.availableTo,
    required this.availableFrom,
    required this.stageType,
    required this.takeTaskButtonText,
    this.openLimit = 0,
    this.totalLimit = 0,
  });

  factory TaskStage.fromJson(Map<String, dynamic> json) {
    return _$TaskStageFromJson(json);
  }

  factory TaskStage.fromApiModel(api.TaskStage model) {
    return TaskStage(
      id: model.id,
      name: model.name,
      description: model.description,
      chain: model.chain,
      campaign: model.campaign,
      cardJsonSchema: model.cardJsonSchema,
      cardUiSchema: model.cardUiSchema,
      availableTo: model.availableTo,
      availableFrom: model.availableFrom,
      stageType: convertStringToStageType(model.stageType),
      openLimit: model.rankLimit?['open_limit'] ?? 0,
      totalLimit: model.rankLimit?['total_limit'] ?? 0,
      takeTaskButtonText: model.takeTaskButtonText,
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageToJson(this);

  @override
  List<Object?> get props => [id, name, description, chain];
}
