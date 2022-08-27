// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';


 part 'categorymodel.g.dart';
@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  CategoryModel(
      {this.iconData,
      this.imageList,
      this.notesText,
      this.reminderIcon,
      this.reminderText,
      this.reminderTimeText,
      this.titel,
      this.color,
      this.rawList,
      this.reminderwidth,
      this.backgroundImage,
      this.reminderColor,
      this.selectedTile,
      this.selectedimage,
      this.path,
      this.crossCount,
      this.isDeletedEdite = false,
      this.duration,
      this.colorSelected,
      this.isSelected = false,
      this.checkScreen = false,
      this.notesController});
  @HiveField(1)
  String? titel;
  @HiveField(2)
  IconData? iconData;
  @HiveField(3)
  String? notesText;
  @HiveField(4)
  List<File>? imageList;
  @HiveField(5)
  IconData? reminderIcon;
  @HiveField(6)
  String? reminderText;
  @HiveField(7)
  String? reminderTimeText;
  @HiveField(8)
  Color? color;
  @HiveField(9)
  bool? isDeletedEdite;
  @HiveField(10)
  List<ListTileData>? rawList;
  @HiveField(11)
  double? reminderwidth;
  @HiveField(12)
  String? backgroundImage;
  @HiveField(13)
  Color? reminderColor;
  @HiveField(14)
  int? selectedTile;
  @HiveField(15)
  int? selectedimage;
  @HiveField(16)
  bool? checkScreen;
  @HiveField(17)
  String? notesController;
  @HiveField(18)
  int? crossCount;
  @HiveField(19)
  String? path;
  @HiveField(20)
  Duration? duration;
  @HiveField(21)
  int? colorSelected;
  @HiveField(22)
  bool? isSelected;
}
