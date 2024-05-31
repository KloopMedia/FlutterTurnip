// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Volume _$VolumeFromJson(Map<String, dynamic> json) => Volume(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      name: json['name'] as String,
      description: json['description'] as String,
      order: json['order'] as int,
      notYetOpenMessage: json['notYetOpenMessage'] as String,
      alreadyClosedMessage: json['alreadyClosedMessage'] as String,
      showTags: json['showTags'] as bool,
      showTagsFilter: json['showTagsFilter'] as bool,
      myTasksText: json['myTasksText'] as String,
      activeTasksText: json['activeTasksText'] as String,
      returnedTasksText: json['returnedTasksText'] as String,
      completedTasksText: json['completedTasksText'] as String,
      trackFk: json['trackFk'] as int,
      openingRanks:
          (json['openingRanks'] as List<dynamic>).map((e) => e as int).toList(),
      closingRanks:
          (json['closingRanks'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$VolumeToJson(Volume instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'order': instance.order,
      'notYetOpenMessage': instance.notYetOpenMessage,
      'alreadyClosedMessage': instance.alreadyClosedMessage,
      'showTags': instance.showTags,
      'showTagsFilter': instance.showTagsFilter,
      'myTasksText': instance.myTasksText,
      'activeTasksText': instance.activeTasksText,
      'returnedTasksText': instance.returnedTasksText,
      'completedTasksText': instance.completedTasksText,
      'trackFk': instance.trackFk,
      'openingRanks': instance.openingRanks,
      'closingRanks': instance.closingRanks,
    };
