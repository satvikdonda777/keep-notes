// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:provider_app/utilities/theme/theme.dart';

class ThemeChanger extends ChangeNotifier {
  String themeText = 'System default';
  int selectedIndex = 2;
  void changeTheme(index, BuildContext context) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      ThemeManager.switchTheme(context, newTheme: LightTheme());
      themeText = 'Light';
      notifyListeners();
    } else if (selectedIndex == 1) {
      themeText = 'Dark';
      ThemeManager.switchTheme(context, newTheme: DarkTheme());
      notifyListeners();
    } else if (selectedIndex == 2) {
      themeText = 'System default';
      ThemeManager.initializeTheme(context);
      notifyListeners();
    }
    notifyListeners();
  }
}
