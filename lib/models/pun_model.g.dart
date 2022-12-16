// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pun_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PunModelAdapter extends TypeAdapter<PunModel> {
  @override
  final int typeId = 2;

  @override
  PunModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PunModel(
      punishment: fields[0] as String,
    )..id = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, PunModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.punishment)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PunModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
