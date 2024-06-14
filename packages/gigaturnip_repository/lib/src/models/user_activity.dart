import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';

part 'user_activity.g.dart';

@JsonSerializable()
class UserActivity {
  final int stage;
  final String stageName;
  final int chain;
  final String chainName;
  final List<int?> ranks;
  final List<int?> inStages;
  final List<int?> outStages;
  final int completeTrue;
  final int completeFalse;
  final int forceCompleteTrue;
  final int forceCompleteFalse;
  final int countTasks;

  const UserActivity({
    required this.stage,
    required this.stageName,
    required this.chain,
    required this.chainName,
    required this.ranks,
    required this.inStages,
    required this.outStages,
    required this.completeTrue,
    required this.completeFalse,
    required this.forceCompleteTrue,
    required this.forceCompleteFalse,
    required this.countTasks,
  });

  factory UserActivity.fromApiModel(api.UserActivity model) {
    return UserActivity(
      stage: model.stage,
      stageName: model.stageName,
      chain: model.chain,
      chainName: model.chainName,
      ranks: model.ranks,
      inStages: model.inStages,
      outStages: model.outStages,
      completeTrue: model.completeTrue,
      completeFalse: model.completeFalse,
      forceCompleteTrue: model.forceCompleteTrue,
      forceCompleteFalse: model.forceCompleteFalse,
      countTasks: model.countTasks,
    );
  }

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return _$UserActivityFromJson(json);
  }
}
