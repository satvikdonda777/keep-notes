// ignore_for_file: public_member_api_docs, prefer_if_null_operators, lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/model/categorymodel/categorymodel.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/recorderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';

import 'package:provider_app/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  int? categorySelectedIndex;

  void setCategorySelectedIndex(int? index) {
    categorySelectedIndex = index;
    notifyListeners();
  }

  List<CategoryModel> allCategory = [];
  void addCheckNotesData(BuildContext context,
      {String? titel,
      IconData? iconData,
      String? notesText,
      List<File>? imageList,
      IconData? reminderIcon,
      String? reminderText,
      String? reminderTimeText,
      Color? color,
      String? backgroundImage,
      Duration? durationText,
      List<ListTileData>? rawList,
      Color? reminderColor,
      int? selectedTile,
      int? selectedImage,
      double? reminderwidth,
      String? path,
      bool? checkScreen,
      int? crossCount,
      int? colorSelected,
      String? notesControllertext}) {
    allCategory.add(CategoryModel(
      iconData: iconData,
      titel: titel,
      notesText: notesText,
      imageList: List.from(imageList!),
      reminderIcon: reminderIcon,
      reminderText: reminderText,
      reminderTimeText: reminderTimeText,
      backgroundImage: backgroundImage,
      color: color,
      path: path,
      colorSelected: colorSelected,
      crossCount: crossCount,
      selectedTile: selectedTile,
      reminderColor: reminderColor,
      reminderwidth: reminderwidth,
      rawList: List.from(rawList!),
      selectedimage: selectedImage,
      checkScreen: checkScreen,
      duration: durationText,
      notesController: notesControllertext,
    ));
    notifyListeners();
  }

  int? indexs;
  void setdata(index) {
    for (final element in deletedItemList) {
      element.isDeletedEdite == true ? indexs = index : null;
    }
    notifyListeners();
  }

  void updateData(
      BuildContext context, AddScreenProvider provider, CategoryModel model) {
    model.backgroundImage =
        provider.selectedbackgroundimage != null ? provider.imageurl : '';
    model.color = provider.colorslist[provider.selectedColor].withOpacity(0.4);
    model.rawList = provider.rowList;
    model.iconData = provider.icon != null ? provider.icon : null;
    model.crossCount = provider.crossaxis;
    model.imageList = List.from(provider.imagelist);
    model.reminderColor =
        provider.selectedTile == null || provider.selectedTile == 4
            ? VariableUtilities.theme.transparent
            : VariableUtilities.theme.keeptextColor.withOpacity(0.2);
    model.reminderIcon = provider.icon != null ? provider.icon : null;
    model.reminderText =
        provider.containertext!.isNotEmpty ? provider.containertext : '';
    model.selectedimage = provider.selectedbackgroundimage;
    model.reminderTimeText =
        provider.timetext!.isNotEmpty ? provider.timetext : '';
    model.reminderwidth =
        provider.containerwidth != null ? provider.containerwidth : 0.0;
    model.selectedTile = provider.selectedTile;
    model.titel = provider.titleController.text;
    model.selectedTile = provider.selectedTile;
    model.notesController = provider.notesController.text;
    model.path =
        Provider.of<RecorderProvider>(context, listen: false).path != null
            ? Provider.of<RecorderProvider>(context, listen: false).path
            : null;
    model.duration =
        Provider.of<RecorderProvider>(context, listen: false).duration != null
            ? Provider.of<RecorderProvider>(context, listen: false).duration
            : null;
    notifyListeners();
  }

  List<Color> colorDialog = [
    Colors.grey.shade900,
    Colors.red,
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.brown,
    Colors.cyanAccent,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.limeAccent,
    Colors.lightGreen,
  ];
  Color? color;
  int? selectedIndex;
  bool isLongPress = false;
  void setColor(BuildContext context, index) {
    for (final element in allCategory) {
      if (element.isSelected == true) {
        element.color = Provider.of<CategoryProvider>(context, listen: false)
            .colorDialog[index]
            .withOpacity(0.4);
        Provider.of<UserProvider>(context, listen: false).isLongPress = false;
        counter = 1;
        isSelectionModeOn = false;
        allCategory[categorySelectedIndex!].isSelected = false;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  bool isSelectionModeOn = false;
  int counter = 1;
  void truevalue(index, BuildContext context) {
    if (isSelectionModeOn == true && allCategory[index].isSelected == true) {
      allCategory[index].isSelected = false;
      counter--;
      if (counter == 0) {
        isSelectionModeOn = false;
        Provider.of<UserProvider>(context, listen: false).isLongPress = false;
        counter = 1;
      }
    } else {
      allCategory[index].isSelected = true;
      counter++;
    }
    notifyListeners();
  }

  void setSelectionMode(bool value, index) {
    isSelectionModeOn = value;
    allCategory[index].isSelected = true;
    categorySelectedIndex = index;
    notifyListeners();
  }

  void onTapClose(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).isLongPress = false;
    isSelectionModeOn = false;
    counter = 1;
    categorySelectedIndex = null;
    for (final element in allCategory) {
      element.isSelected = false;
    }

    notifyListeners();
  }

  List<CategoryModel> deletedItemList = [];
  void deleteElement(BuildContext context) {
    deletedItemList.addAll(
        (allCategory.where((element) => element.isSelected == true)).toList());
    allCategory.removeWhere((element) => element.isSelected == true);
    counter = 1;
    for (final element in deletedItemList) {
      element.isDeletedEdite = true;
    }
    Provider.of<UserProvider>(context, listen: false).isLongPress = false;
    isSelectionModeOn = false;
    notifyListeners();
  }

  void undodelete() {
    allCategory.addAll(deletedItemList
        .where((element) => element.isSelected == true)
        .toList());

    deletedItemList.removeWhere((element) => element.isSelected == true);
    for (final element in allCategory) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  void undoDeletedBorder() {
    for (final element in deletedItemList) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  void undoArchiveBorder() {
    for (final element in archiveItemsList) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  void undoArchive() {
    allCategory.addAll(archiveItemsList
        .where((element) => element.isSelected == true)
        .toList());

    archiveItemsList.removeWhere((element) => element.isSelected == true);
    for (final element in allCategory) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  List<CategoryModel> archiveItemsList = [];
  void archiveData(BuildContext context) {
    archiveItemsList
        .addAll(allCategory.where((element) => element.isSelected == true));
    allCategory.removeWhere((element) => element.isSelected == true);
    counter = 1;
    Provider.of<UserProvider>(context, listen: false).isLongPress = false;
    isSelectionModeOn = false;

    notifyListeners();
  }

  void addReminder(AddScreenProvider provider, BuildContext context) {
    if (provider.selectedTile == null) {
      for (final element in allCategory) {
        if (element.isSelected == true) {
          element.selectedTile = provider.selectedTile = 1;
          element.reminderColor =
              VariableUtilities.theme.whiteColor.withOpacity(0.3);
          element.reminderwidth = provider.containerwidth = 170;
          element.reminderIcon = provider.icon = Icons.watch_later_outlined;
          element.reminderText = provider.containertext = 'Today ';
          element.reminderTimeText = provider.timetext =
              const TimeOfDay(hour: 18, minute: 00).format(context);
          selected = DateTime.now();
          timeOfDay = const TimeOfDay(hour: 18, minute: 0);
        }
      }
    } else {
      for (var element in allCategory) {
        if (element.isSelected == true) {
          element.selectedTile = provider.selectedTile;
          element.reminderwidth = provider.containerwidth;
          element.reminderIcon = provider.icon;
          element.reminderText = provider.containertext;
          element.reminderTimeText = provider.timetext;
          element.reminderColor =
              VariableUtilities.theme.whiteColor.withOpacity(0.3);
        }
      }
    }
    provider.containerTextList.add(provider.containertext);
    provider.timeTextList.add(provider.timetext);
    notifyListeners();
  }

  void setReminder(BuildContext context) {
    for (final element in allCategory) {
      if (element.isSelected == true) {
        element.reminderIcon =
            Provider.of<AddScreenProvider>(context, listen: false).icon;
        element.reminderText =
            Provider.of<AddScreenProvider>(context, listen: false)
                .containertext;
        element.reminderTimeText =
            Provider.of<AddScreenProvider>(context, listen: false).timetext;
        element.reminderwidth =
            Provider.of<AddScreenProvider>(context, listen: false)
                .containerwidth;
        counter = 1;
        isSelectionModeOn = false;
        allCategory[categorySelectedIndex!].isSelected = false;
        Provider.of<UserProvider>(context, listen: false).isLongPress = false;
        for (final element in allCategory) {
          element.isSelected = false;
        }
        notifyListeners();
      }
    }
  }

  void deleteAllData() {
    deletedItemList.clear();
    notifyListeners();
  }

  var box = Hive.box('key');
  void storeLocalData() {
    box.put('box', allCategory);
    notifyListeners();
  }

  List<CategoryModel> allCategory1 = [];
  void getLocalData() {
    allCategory1 = box.get('box');
    print("Hehehee${allCategory1.length}");
    notifyListeners();
  }
}
