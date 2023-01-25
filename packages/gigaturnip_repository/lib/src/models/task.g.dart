// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as int,
      name: fields[1] as String,
      responses: (fields[4] as Map?)?.cast<String, dynamic>(),
      complete: fields[5] as bool,
      reopened: fields[6] as bool,
      stage: fields[7] as TaskStage,
      createdAt: fields[8] as DateTime?,
      schema: (fields[2] as Map?)?.cast<String, dynamic>(),
      uiSchema: (fields[3] as Map?)?.cast<String, dynamic>(),
      cardJsonSchema: (fields[9] as Map?)?.cast<String, dynamic>(),
      cardUiSchema: (fields[10] as Map?)?.cast<String, dynamic>(),
      displayedPrevTasks: (fields[11] as List).cast<Task>(),
      isIntegrated: fields[12] as bool,
      dynamicSource: (fields[13] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      dynamicTarget: (fields[14] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.schema)
      ..writeByte(3)
      ..write(obj.uiSchema)
      ..writeByte(4)
      ..write(obj.responses)
      ..writeByte(5)
      ..write(obj.complete)
      ..writeByte(6)
      ..write(obj.reopened)
      ..writeByte(7)
      ..write(obj.stage)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.cardJsonSchema)
      ..writeByte(10)
      ..write(obj.cardUiSchema)
      ..writeByte(11)
      ..write(obj.displayedPrevTasks)
      ..writeByte(12)
      ..write(obj.isIntegrated)
      ..writeByte(13)
      ..write(obj.dynamicSource)
      ..writeByte(14)
      ..write(obj.dynamicTarget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      name: json['name'] as String,
      responses: json['responses'] as Map<String, dynamic>?,
      complete: json['complete'] as bool,
      reopened: json['reopened'] as bool,
      stage: TaskStage.fromJson(json['stage'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      schema: json['schema'] as Map<String, dynamic>?,
      uiSchema: json['uiSchema'] as Map<String, dynamic>?,
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
      displayedPrevTasks: (json['displayedPrevTasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      isIntegrated: json['isIntegrated'] as bool,
      dynamicSource: (json['dynamicSource'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      dynamicTarget: (json['dynamicTarget'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'schema': instance.schema,
      'uiSchema': instance.uiSchema,
      'responses': instance.responses,
      'complete': instance.complete,
      'reopened': instance.reopened,
      'stage': instance.stage.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'displayedPrevTasks':
          instance.displayedPrevTasks.map((e) => e.toJson()).toList(),
      'isIntegrated': instance.isIntegrated,
      'dynamicSource': instance.dynamicSource,
      'dynamicTarget': instance.dynamicTarget,
    };
