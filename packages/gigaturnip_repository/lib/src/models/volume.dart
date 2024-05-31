import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';

part 'volume.g.dart';

@JsonSerializable(explicitToJson: true)
class Volume {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final int order;
  final String notYetOpenMessage;
  final String alreadyClosedMessage;
  final bool showTags;
  final bool showTagsFilter;
  final String myTasksText;
  final String activeTasksText;
  final String returnedTasksText;
  final String completedTasksText;
  final int trackFk;
  final List<int> openingRanks;
  final List<int> closingRanks;

  Volume({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.order,
    required this.notYetOpenMessage,
    required this.alreadyClosedMessage,
    required this.showTags,
    required this.showTagsFilter,
    required this.myTasksText,
    required this.activeTasksText,
    required this.returnedTasksText,
    required this.completedTasksText,
    required this.trackFk,
    required this.openingRanks,
    required this.closingRanks,
  });

  factory Volume.fromJson(Map<String, dynamic> json) {
    return _$VolumeFromJson(json);
  }

  factory Volume.fromApiModel(api.Volume model) {
    return Volume(
      id: model.id,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      name: model.name,
      description: model.description,
      order: model.order,
      notYetOpenMessage: model.notYetOpenMessage,
      alreadyClosedMessage: model.alreadyClosedMessage,
      showTags: model.showTags,
      showTagsFilter: model.showTagsFilter,
      myTasksText: model.myTasksText,
      activeTasksText: model.activeTasksText,
      returnedTasksText: model.returnedTasksText,
      completedTasksText: model.completedTasksText,
      trackFk: model.trackFk,
      openingRanks: model.openingRanks,
      closingRanks: model.closingRanks,
    );
  }
}
