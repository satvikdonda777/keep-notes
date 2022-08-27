// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorymodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 1;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      iconData: fields[2] as IconData?,
      imageList: (fields[4] as List?)?.cast<File>(),
      notesText: fields[3] as String?,
      reminderIcon: fields[5] as IconData?,
      reminderText: fields[6] as String?,
      reminderTimeText: fields[7] as String?,
      titel: fields[1] as String?,
      color: fields[8] as Color?,
      rawList: (fields[10] as List?)?.cast<ListTileData>(),
      reminderwidth: fields[11] as double?,
      backgroundImage: fields[12] as String?,
      reminderColor: fields[13] as Color?,
      selectedTile: fields[14] as int?,
      selectedimage: fields[15] as int?,
      path: fields[19] as String?,
      crossCount: fields[18] as int?,
      isDeletedEdite: fields[9] as bool?,
      duration: fields[20] as Duration?,
      colorSelected: fields[21] as int?,
      isSelected: fields[22] as bool?,
      checkScreen: fields[16] as bool?,
      notesController: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(1)
      ..write(obj.titel)
      ..writeByte(2)
      ..write(obj.iconData)
      ..writeByte(3)
      ..write(obj.notesText)
      ..writeByte(4)
      ..write(obj.imageList)
      ..writeByte(5)
      ..write(obj.reminderIcon)
      ..writeByte(6)
      ..write(obj.reminderText)
      ..writeByte(7)
      ..write(obj.reminderTimeText)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.isDeletedEdite)
      ..writeByte(10)
      ..write(obj.rawList)
      ..writeByte(11)
      ..write(obj.reminderwidth)
      ..writeByte(12)
      ..write(obj.backgroundImage)
      ..writeByte(13)
      ..write(obj.reminderColor)
      ..writeByte(14)
      ..write(obj.selectedTile)
      ..writeByte(15)
      ..write(obj.selectedimage)
      ..writeByte(16)
      ..write(obj.checkScreen)
      ..writeByte(17)
      ..write(obj.notesController)
      ..writeByte(18)
      ..write(obj.crossCount)
      ..writeByte(19)
      ..write(obj.path)
      ..writeByte(20)
      ..write(obj.duration)
      ..writeByte(21)
      ..write(obj.colorSelected)
      ..writeByte(22)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
