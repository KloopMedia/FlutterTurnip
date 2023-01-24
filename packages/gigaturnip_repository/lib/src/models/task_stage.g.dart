// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskStageAdapter extends TypeAdapter<TaskStage> {
  @override
  final int typeId = 1;

  @override
  TaskStage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskStage(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      chain: fields[3] as Chain,
      richText: fields[4] as String?,
      cardJsonSchema: (fields[5] as Map?)?.cast<String, dynamic>(),
      cardUiSchema: (fields[6] as Map?)?.cast<String, dynamic>(),
      jsonSchema: (fields[7] as Map?)?.cast<String, dynamic>(),
      uiSchema: (fields[8] as Map?)?.cast<String, dynamic>(),
      dynamicJsonsSource: (fields[9] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      dynamicJsonsTarget: (fields[10] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskStage obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.chain)
      ..writeByte(4)
      ..write(obj.richText)
      ..writeByte(5)
      ..write(obj.cardJsonSchema)
      ..writeByte(6)
      ..write(obj.cardUiSchema)
      ..writeByte(7)
      ..write(obj.jsonSchema)
      ..writeByte(8)
      ..write(obj.uiSchema)
      ..writeByte(9)
      ..write(obj.dynamicJsonsSource)
      ..writeByte(10)
      ..write(obj.dynamicJsonsTarget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStage _$TaskStageFromJson(Map<String, dynamic> json) => TaskStage(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      chain: Chain.fromJson(json['chain'] as Map<String, dynamic>),
      richText: json['richText'] as String?,
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
      jsonSchema: json['jsonSchema'] as Map<String, dynamic>?,
      uiSchema: json['uiSchema'] as Map<String, dynamic>?,
      dynamicJsonsSource: (json['dynamicJsonsSource'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      dynamicJsonsTarget: (json['dynamicJsonsTarget'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$TaskStageToJson(TaskStage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain.toJson(),
      'richText': instance.richText,
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'jsonSchema': instance.jsonSchema,
      'uiSchema': instance.uiSchema,
      'dynamicJsonsSource': instance.dynamicJsonsSource,
      'dynamicJsonsTarget': instance.dynamicJsonsTarget,
    };
