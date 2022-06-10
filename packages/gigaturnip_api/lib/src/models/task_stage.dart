import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/src/models/models.dart';

part 'task_stage.g.dart';

@JsonSerializable()
class TaskStage {
  final int id;
  final String name;
  final List<Chain> chain;
  final List<int> inStages;
  final List<int> outStages;
  final int xPos;
  final int yPos;
  final List<String> jsonSchema;
  final List<String> uiSchema;
  final String library;
  final bool copyInput;
  final bool allowMultipleFiles;
  final bool isCreatable;
  final List<int> displayedPrevStages;
  final String assignUserBy;
  final String richText;
  final String webhookAddress;
  final String webhookPlayloadFields;
  final String webhookParams;
  final List<dynamic> dynamicJsons;
  final String webhookResponseField;
  final bool allowGoBack;
  final bool allowRelease;


  TaskStage({
    required this.id,
    required this.name,
    required this.chain,
    required this.inStages,
    required this.outStages,
    required this.yPos,
    required this.xPos,
    required this.jsonSchema,
    required this.uiSchema,
    required this.library,
    required this. copyInput,
    required this.allowMultipleFiles,
    required this.isCreatable,
    required this.displayedPrevStages,
    required this.assignUserBy,
    required this.richText,
    required this.webhookAddress,
    required this.webhookPlayloadFields,
    required this.webhookParams,
    required this.dynamicJsons,
    required this.webhookResponseField,
    required this.allowGoBack,
    required this.allowRelease
  });


  factory TaskStage.fromJson(Map<String, dynamic> json) {
    return _$TaskStageFromJson(json);
  }
}
