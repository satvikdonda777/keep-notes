import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/theme/themeprovider.dart';
import 'package:provider_app/utilities/theme/theme.dart';

class SettingsProvider extends ChangeNotifier {
  bool isbuttonon1 = false;
  bool isbuttonon2 = false;
  bool isbuttonon3 = false;
  bool isbuttonon4 = false;

  void changeSwithValue1() {
    isbuttonon1 = !isbuttonon1;
    notifyListeners();
  }

  void changeSwithValue2() {
    isbuttonon2 = !isbuttonon2;
    notifyListeners();
  }

  void changeSwithValue3() {
    isbuttonon3 = !isbuttonon3;
    notifyListeners();
  }

  void changeSwithValue4() {
    isbuttonon4 = !isbuttonon4;
    notifyListeners();
  }


  TimeOfDay selectedtime = TimeOfDay(hour: 8, minute: 00);
  String timeText = '8:00 am';
  Future showtimePicker(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      initialTime: selectedtime,
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null || timeOfDay != selectedtime) {
      timeText = timeOfDay!.format(context);
      notifyListeners();
    }
  }

  TimeOfDay selectedtime1 = TimeOfDay(hour: 13, minute: 00);
  String timeText1 = '1:00 pm';
  Future showtimePicker1(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      initialTime: selectedtime1,
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null || timeOfDay != selectedtime1) {
      timeText1 = timeOfDay!.format(context);
      notifyListeners();
    }
  }

  TimeOfDay selectedtime2 = TimeOfDay(hour: 18, minute: 00);
  String timeText2 = '6:00 pm';
  Future showtimePicker2(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      initialTime: selectedtime2,
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null || timeOfDay != selectedtime2) {
      timeText2 = timeOfDay!.format(context);
      notifyListeners();
    }
  }
}
