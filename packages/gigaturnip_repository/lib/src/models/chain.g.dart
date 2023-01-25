// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChainAdapter extends TypeAdapter<Chain> {
  @override
  final int typeId = 2;

  @override
  Chain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chain(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      campaign: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Chain obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.campaign);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chain _$ChainFromJson(Map<String, dynamic> json) => Chain(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      campaign: json['campaign'] as int,
    );

Map<String, dynamic> _$ChainToJson(Chain instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'campaign': instance.campaign,
    };
