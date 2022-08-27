import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';

class ReminderProvider extends ChangeNotifier {
  bool isWindowiconSelect = false;

  void toggleIcon() {
    isWindowiconSelect = !isWindowiconSelect;
    notifyListeners();
  }

  bool isLongPress = false;
  void onLongPress() {
    isLongPress = !isLongPress;
    notifyListeners();
  }

  void closeLongPress() {
    isLongPress = false;

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

  int selectedIndex = 0;
  void selectColor(index, BuildContext context) {
    selectedIndex = index;
    isLongPress = false;
    Provider.of<AddScreenProvider>(context, listen: false).colorslist[
        Provider.of<AddScreenProvider>(context, listen: false)
            .selectedColor] = colorDialog[index].withOpacity(0.8);
    notifyListeners();
  }

  void disposeLongPress() {
    isLongPress = false;
    notifyListeners();
  }

  List timetextList = [];
}
