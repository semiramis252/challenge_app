// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chall_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallModelAdapter extends TypeAdapter<ChallModel> {
  @override
  final int typeId = 1;

  @override
  ChallModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChallModel(
      challenge: fields[0] as String,
    )..id = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, ChallModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.challenge)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
