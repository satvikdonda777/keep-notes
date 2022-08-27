import 'package:flutter/cupertino.dart';

class CustomIconProvider extends ChangeNotifier {
  bool isSelected = false;
  void toggleIcon() {
    isSelected = !isSelected;
    notifyListeners();
  }
}
