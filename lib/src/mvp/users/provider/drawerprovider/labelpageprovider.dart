import 'package:flutter/cupertino.dart';


class LabelPageProvider extends ChangeNotifier {
  bool isiconSelected = false;
  void toggleIcon() {
    isiconSelected = !isiconSelected;
    notifyListeners();
  }
}
