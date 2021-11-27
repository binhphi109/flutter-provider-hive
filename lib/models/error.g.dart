// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ErrorAdapter extends TypeAdapter<Error> {
  @override
  final int typeId = 7;

  @override
  Error read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Error(
      id: fields[0] as int,
      type: fields[1] as String,
      text: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Error obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return Error(
    id: json['id'] as int,
    type: json['type'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'text': instance.text,
    };
