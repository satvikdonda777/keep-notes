// ignore_for_file: unused_local_variable, public_member_api_docs

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';

File? imagefile1;
String emailtext = '';

class UserProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  int? selectedIndex = 0;
  void checkSelecton(int index) {
    selectedIndex = index;
    selectedIndex1 = null;
    notifyListeners();
  }

  bool isGridview = false;
  void checkView() {
    if (isGridview == false) {
      isGridview = true;
    } else {
      isGridview = false;
      notifyListeners();
    }
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

  void takephoto(ImageSource source, BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      imagefile1 = File(pickedFile.path);
    }
    Provider.of<AddScreenProvider>(context).imagelist.add(imagefile1!);

    notifyListeners();
  }

  int? selectedIndex1;
  bool isFromindex2 = false;
  void checkSelecton1(int index) {
    selectedIndex1 = index;
    selectedIndex = null;
    notifyListeners();
  }

  bool isLongPress = false;
  bool isStartSelection = false;
  void onLongPress() {
    isLongPress = true;

    notifyListeners();
  }

  void startSelection() {
    isStartSelection = true;
    notifyListeners();
  }

  int? multiSelectedIndex;
  void setSelectedindex(index) {
    multiSelectedIndex = index;
    notifyListeners();
  }

  void reorderData(int oldIndex, int newIndex,BuildContext context) {
    if (newIndex > oldIndex) {
      newIndex = 1;
    }
    final items = Provider.of<CategoryProvider>(context, listen: false)
        .allCategory
        .removeAt(oldIndex);
    Provider.of<CategoryProvider>(context, listen: false)
        .allCategory
        .insert(newIndex, items);
  }
}
