// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

TextEditingController mainTextEditingController = TextEditingController();

class LabelProvider extends ChangeNotifier {
  bool isClosePressed = false;

  void toggleDivider() {
    isClosePressed = !isClosePressed;
    selectedIndex = null;
    notifyListeners();
  }

  List labelRow = [];
  List textController = [mainTextEditingController.text];
  void addlabeltoList() {
    labelRow.add(LabelListTile(textEditingController: TextEditingController()));
    textController.add(mainTextEditingController.text);
    notifyListeners();
  }

  bool isselectedindex = false;
  int? selectedIndex;
  void onRowClick(index) {
    selectedIndex = index;
    isClosePressed = true;
  }

  void ondeleteButton(int index) {
    labelRow.removeAt(index);
    textController.removeAt(index + 1);
    notifyListeners();
  }

  Future ondeleteButton1(int index) async {
    labelRow.removeAt(index);
    textController.removeAt(index + 1);
    print('LABEL :${textController.length}');
    notifyListeners();
  }

  void onlabelSelected() {
    selectedIndex = null;
    notifyListeners();
  }

  void onTextClicked(index) {
    selectedIndex = index;
    isClosePressed = true;
    notifyListeners();
  }

  void onEditClicked(index) {
    selectedIndex = index;
    isClosePressed = true;
    notifyListeners();
  }

  void updateinitialvalue(String value, index) {
    if (value != null || value.isNotEmpty) {
      textController[index + 1] = value;
    } else {}

    notifyListeners();
  }
}

class LabelListTile {
  LabelListTile({required this.textEditingController, this.isSelected = false});
  bool isSelected;
  TextEditingController textEditingController = TextEditingController();
}
