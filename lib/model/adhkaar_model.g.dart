// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adhkaar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdhkaarModelAdapter extends TypeAdapter<AdhkaarModel> {
  @override
  final int typeId = 1;

  @override
  AdhkaarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdhkaarModel(
      title: fields[0] as String,
      subtitle: fields[1] as String,
      countMade: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AdhkaarModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.countMade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdhkaarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
