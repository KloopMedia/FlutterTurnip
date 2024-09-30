import 'package:json_annotation/json_annotation.dart';

part 'volume.g.dart';

@JsonSerializable()
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
  final bool userHasDefaultRank;
  final bool userHasOpeningRanks;
  final bool userHasClosingRanks;

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
    required this.userHasDefaultRank,
    required this.userHasOpeningRanks,
    required this.userHasClosingRanks,
  });

  factory Volume.fromJson(Map<String, dynamic> json) {
    return _$VolumeFromJson(json);
  }
}
