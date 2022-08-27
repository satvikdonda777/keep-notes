// ignore_for_file: public_member_api_docs, unnecessary_new, lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/notification/user_notification.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/customdialog.dart';

import 'package:provider_app/utilities/utilities.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'recorderprovider.dart';

bool ischeckscreen = false;
File? imagefile;
List<String> imagePaths = [];

int initialindex = 0;
TextEditingController textEditingController = TextEditingController();
TimeOfDay? timeOfDay;
DateTime? selected;
DateTimeComponents? repeatNotification;

class ListTileData {
  ListTileData({
    required this.textEditingController,
    this.isSelected = false,
  });
  bool isSelected;
  TextEditingController textEditingController;
}

class AddScreenProvider extends ChangeNotifier {
  List<File> imagelist = [];
  int crossaxis = 1;
  void clearImagelist() {
    imagelist.clear();
    notifyListeners();
  }

  void addImage(File image) {
    imagelist.add(image);
    notifyListeners();
  }

  void removeindexImage(index) {
    imagelist.removeAt(index);
    imagePaths.removeAt(index);
    changecrossAxiscount();
    notifyListeners();
  }

  bool isbackgroundImage = false;
  int initialIndex = 12;
  void changePage(value) {
    initialIndex = value;
    notifyListeners();
  }

  List textControllerList = [];
  List<ListTileData> rowList = [
    ListTileData(
      textEditingController: TextEditingController(),
    )
  ];
  final ImagePicker _picker = ImagePicker();
  void takephoto(ImageSource source, BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      imagefile = File(pickedFile.path);
      imagePaths.add(pickedFile.path);
    }
    imagelist.add(imagefile!);

    changecrossAxiscount();
    notifyListeners();
  }

  Future<void> requestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      takephoto(ImageSource.camera, context);
    } else if (status == PermissionStatus.denied) {
      await requestCameraPermission(context);
    } else if (status == PermissionStatus.permanentlyDenied) {}
  }

  Future<void> requestStoragePermission(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      takephoto(ImageSource.gallery, context);
    } else if (status == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied) {}
  }

  bool isundoSelected = false;
  TextEditingController titleController = TextEditingController();
  void toggleselectedValue(bool value, int index) {
    rowList[index].isSelected = value;
    notifyListeners();
  }

  TextEditingController notesController = TextEditingController();

  void changeUndoIconColor() {
    if (isundoSelected == false) {
      isundoSelected = true;
    } else if (isundoSelected == true) {
      isundoSelected = false;
    }
    notifyListeners();
  }

  List bottomsheetitem = [
    {
      'title': 'Delete',
      'icon': Icons.delete_outlined,
      'index': 0,
    },
    {
      'title': 'Make a copy',
      'icon': Icons.copy_rounded,
      'index': 1,
    },
    {
      'title': 'Send',
      'icon': Icons.share_outlined,
      'index': 2,
    },
    {
      'title': 'Collabortor',
      'icon': Icons.person_add_alt,
      'index': 3,
    },
    {
      'title': 'Labels',
      'icon': Icons.label_outline_sharp,
      'index': 4,
    },
  ];

  List addboxBottomsheet = [
    {
      'title': 'Take photo',
      'icon': Icons.camera_alt_outlined,
      'index': 0,
    },
    {
      'title': 'Add image',
      'icon': Icons.photo_camera_back,
      'index': 1,
    },
    {
      'title': 'Drawing',
      'icon': Icons.brush,
      'index': 2,
    },
    {
      'title': 'Recording',
      'icon': Icons.keyboard_voice_outlined,
      'index': 3,
    },
  ];

  List<Color> colorslist = [
    Colors.grey.shade800,
    Colors.pink.shade800,
    Colors.brown.shade800,
    Colors.brown.shade400,
    Colors.green.shade800,
    Colors.lightGreen.shade800,
    Colors.cyan.shade800,
    Colors.blue.shade800,
    Colors.purple.shade800,
    Colors.pinkAccent.shade400,
    Colors.brown.shade400,
    Colors.black
  ];

  int selectedColor = 0;
  void checkSelectedColor(index) {
    selectedColor = index;
    notifyListeners();
  }

  bool isSelected = false;
  void toggleIcon() {
    isSelected = !isSelected;
    notifyListeners();
  }

  bool isSelectedPlace1 = false;
  bool isSelectedPlace = false;
  void checkPlace() {
    isSelectedPlace = !isSelectedPlace;
    notifyListeners();
  }

  void checkPlace1() {
    isSelectedPlace1 = !isSelectedPlace1;
    notifyListeners();
  }

  int? selectedTile;
  String? containertext = '';
  IconData? icon;

  double? containerwidth;
  void showContainer(index, BuildContext context) {
    selectedTile = index;
    if (selectedTile == 0) {
      timetext = const TimeOfDay(hour: 18, minute: 00).format(context);
      icon = Icons.alarm;
      initialindex = 0;
      NotificationService.showScheduledNotification(
          id: 1, title: titleController.text, body: titleController.text);
      timeOfDay = const TimeOfDay(hour: 18, minute: 00);
      containerwidth = 180;
      repeatNotification = null;
      selected = DateTime.now();
      containertext = 'Today, ';
      timeTextList.add(timetext);
      containerTextList.add(containertext);
    } else if (selectedTile == 1) {
      initialindex = 0;
      timetext = const TimeOfDay(hour: 20, minute: 00).format(context);
      NotificationService.showScheduledNotification(
          id: 2, title: titleController.text, body: titleController.text);
      containertext = 'Tomorrow, ';
      containerwidth = 220;
      repeatNotification = null;
      selected = DateTime.now().add(const Duration(days: 1));
      icon = Icons.alarm;
      timeOfDay = const TimeOfDay(hour: 8, minute: 00);
      timeTextList.add(timetext);
      containerTextList.add(containertext);
    } else if (selectedTile == 2) {
      initialindex = 0;
      NotificationService.showScheduledNotification(
          id: 3, title: titleController.text, body: titleController.text);
      icon = Icons.alarm;
      containerwidth = 210;
      timetext = const TimeOfDay(hour: 20, minute: 00).format(context);
      repeatNotification = null;
      selected = DateTime.now().add(const Duration(days: 7));
      containertext =
          "${DateFormat('d-MMMM').format(DateTime.now().add(const Duration(days: 7)))}, ";
      timeOfDay = const TimeOfDay(hour: 20, minute: 00);
      timeTextList.add(timetext);
      containerTextList.add(containertext);
    } else if (selectedTile == 3) {
      initialindex = 1;
      if (timetext != '') {
        containerwidth = 170;
      }
      containerwidth = 100;
      timetext = '';
      repeatNotification = null;
      icon = Icons.location_on_outlined;
      containertext = 'Home';
    } else if (selectedTile == 4) {
      containertext = '';
      timetext = '';
      repeatNotification = null;
      icon = null;
    } else if (selectedTile == 5) {
      notifyListeners();
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog();
          });
      repeatNotification = null;
      containertext = 'Today, ';
      timetext = '8:00 pm';
      icon = Icons.alarm;
      containerwidth = 220;
      initialindex = 0;
      timeTextList.add(timetext);
      containerTextList.add(containertext);
    } else if (selectedTile == 6) {
      notifyListeners();
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog();
          });
      containertext = 'Today, ';
      timetext = '8:00 pm';
      icon = Icons.alarm;
      containerwidth = 220;
      repeatNotification = null;
      initialindex = 1;
      timeTextList.add(timetext);
      containerTextList.add(containertext);
    }
    notifyListeners();
  }

  void showdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog();
        });
    initialindex = 1;
    notifyListeners();
  }

  void showdialog1(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog();
        });
    initialindex = 1;
    notifyListeners();
  }

  String hintText = DateFormat('d-MMMM').format(DateTime.now());
  String? dropdownvalue;
  List items = ['Today', 'Tomorrow', 'Next Wednesday', 'Select a date'];
  DateTime selectedDate = DateTime.now();
  void onchanged(newValue, BuildContext context) async {
    if (newValue == items[0]) {
      icon = Icons.alarm;
      containerwidth = 190;
      repeatNotification = null;
      containertext = 'Today, ';
      timeOfDay = const TimeOfDay(hour: 18, minute: 00);
      hintText = DateFormat('d-MMMM').format(DateTime.now());
    } else if (newValue == items[1]) {
      selected = DateTime.now().add(const Duration(days: 1));
      timeOfDay = const TimeOfDay(hour: 18, minute: 00);
      icon = Icons.alarm;
      containerwidth = 225;
      repeatNotification = null;
      containertext = 'Tomorrow, ';
      hintText = DateFormat('d-MMMM')
          .format(DateTime.now().add(const Duration(days: 1)));
    } else if (newValue == items[2]) {
      selected = DateTime.now().add(const Duration(days: 7));
      timeOfDay = const TimeOfDay(hour: 18, minute: 00);
      containerwidth = 190;
      icon = Icons.alarm;
      repeatNotification = null;
      containertext =
          "${DateFormat('d-MMMM').format(DateTime.now().add(const Duration(days: 7)))}, ";
      hintText = DateFormat('d-MMMM')
          .format(DateTime.now().add(const Duration(days: 7)));
    } else if (newValue == items[3]) {
      selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );
      if (selected != null && selected != selectedDate) {
        repeatNotification = null;
        selectedDate = selected!;
        icon = Icons.alarm;
        timeOfDay = const TimeOfDay(hour: 18, minute: 00);
        hintText = DateFormat('d-MMMM').format(selectedDate);
        containerwidth = 205;
        containertext = DateFormat('d-MMMM').format(selectedDate);
      }
      if (containertext == 'Home') {
        timetext = '';
        repeatNotification = null;
      }
    }
    notifyListeners();
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  String hintText1 = '8:00 am';
  String? dropdownvalue1;
  String? timetext = '';
  List dropitem = [
    {
      'title': 'Morning',
      'time': '8:00 am',
    },
    {
      'title': 'Afternoon',
      'time': '1:00 pm',
    },
    {
      'title': 'Evening',
      'time': '6:00 pm',
    },
    {
      'title': 'night',
      'time': '8:00 pm',
    },
    {'title': 'Select a time....', 'time': ''}
  ];
  void onchanged1(newValue, BuildContext context) async {
    if (newValue == dropitem[0]) {
      icon = Icons.alarm;
      hintText1 = '8:00 am';
      timetext = const TimeOfDay(hour: 8, minute: 00).format(context);
      repeatNotification = null;
      timeOfDay = const TimeOfDay(hour: 8, minute: 00);
    } else if (newValue == dropitem[1]) {
      icon = Icons.alarm;
      hintText1 = '1:00 pm';
      timetext = const TimeOfDay(hour: 13, minute: 00).format(context);
      repeatNotification = null;
      timeOfDay = const TimeOfDay(hour: 13, minute: 00);
    } else if (newValue == dropitem[2]) {
      icon = Icons.alarm;
      hintText1 = '6:00 pm';
      repeatNotification = null;
      timetext = const TimeOfDay(hour: 18, minute: 00).format(context);
      timeOfDay = const TimeOfDay(hour: 18, minute: 00);
    } else if (newValue == dropitem[3]) {
      icon = Icons.alarm;
      repeatNotification = null;
      hintText1 = '8:00 pm';
      timetext = const TimeOfDay(hour: 20, minute: 00).format(context);
      timeOfDay = const TimeOfDay(hour: 20, minute: 00);
    } else if (newValue == dropitem[4]) {
      timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
      );
      if (timeOfDay != null && timeOfDay != selectedTime) {
        icon = Icons.alarm;
        repeatNotification = null;
        containerwidth = 205;
        hintText1 = timeOfDay!.format(context).toString();
        timetext = timeOfDay!.format(context).toString();
      }
    }
    if (containertext == 'Home') {
      timetext = '';
    }
    notifyListeners();
  }

  List drop2itmes = [
    'Does not repeat',
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Custom...'
  ];
  String hintText2 = 'Does not repeat';
  void onchanged2(newValue, BuildContext context) async {
    if (newValue == drop2itmes[0]) {
      icon = Icons.alarm;
      hintText2 = 'Does not repeat';
      repeatNotification = null;
    } else if (newValue == drop2itmes[1]) {
      icon = Icons.repeat;
      hintText2 = 'Repeates daily';
      repeatNotification = DateTimeComponents.dateAndTime;
    } else if (newValue == drop2itmes[2]) {
      icon = Icons.repeat;
      repeatNotification = DateTimeComponents.dayOfWeekAndTime;
      hintText2 = 'Repeates weekly';
    } else if (newValue == drop2itmes[3]) {
      icon = Icons.repeat;
      repeatNotification = DateTimeComponents.dayOfMonthAndTime;
      hintText2 = 'Repeates monthly';
    } else if (newValue == drop2itmes[4]) {
      icon = Icons.repeat;
      hintText2 = 'Repeates ennually';
    } else if (newValue == drop2itmes[4]) {
      icon = Icons.repeat;
      hintText2 = 'Repeates ennually';
    }
    if (containertext == 'Home') {
      timetext = '';
    }

    notifyListeners();
  }

  List timeTextList = [];
  List containerTextList = [];
  void ondelete() {
    selectedTile = null;
    containertext = '';
    icon = null;
    timetext = '';

    notifyListeners();
  }

  List imageList = [
    AssetUtilities.backgroundimage1,
    AssetUtilities.backgroundimage2,
    AssetUtilities.backgroundimage3,
    AssetUtilities.backgroundimage4
  ];
  String? imageurl;
  Color? bottomsheetbackgroundColor;
  int? selectedbackgroundimage;
  void backgroundImagechange(index) {
    selectedbackgroundimage = index;
    if (selectedbackgroundimage == 0) {
      imageurl = imageList[0];
      bottomsheetbackgroundColor = Colors.lightGreen.shade600;
    } else if (selectedbackgroundimage == 1) {
      imageurl = imageList[1];
      bottomsheetbackgroundColor = Colors.green.shade300;
    } else if (selectedbackgroundimage == 2) {
      imageurl = imageList[2];
      bottomsheetbackgroundColor = Colors.green;
    } else if (selectedbackgroundimage == 3) {
      imageurl = imageList[3];
      bottomsheetbackgroundColor = Colors.blue;
    }
    notifyListeners();
  }

  void onbackarrow(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false)
        .categorySelectedIndex = null;
    // imagelist.clear();
    imagePaths.clear();
    ischeckscreen = false;
    selectedColor = 0;
    Provider.of<CategoryProvider>(context, listen: false).indexs = null;
    Provider.of<RecorderProvider>(context, listen: false).path = null;
    selectedbackgroundimage = 3;
    if (rowList.isNotEmpty) {
      rowList.removeRange(1, rowList.length);
      notifyListeners();
    } else if (rowList.isEmpty) {
      rowList.add(ListTileData(textEditingController: TextEditingController()));
      notifyListeners();
    }

    imageurl = null;
    bottomsheetbackgroundColor = VariableUtilities.theme.backgroundColor;
    titleController.clear();
    icon = null;
    containertext = '';
    timetext = '';
    selectedTile = null;
    colorslist[selectedColor] = VariableUtilities.theme.backgroundColor;
    notifyListeners();
  }

  void onclosebutton(int index) {
    rowList.removeAt(index);
    notifyListeners();
  }

  void addRow() {
    rowList.add(ListTileData(
      textEditingController: TextEditingController(),
    ));

    notifyListeners();
  }

  void onsendButton(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: titleController.text.isEmpty ? '' : titleController.text,
          subject: 'I dont know',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else if (imagePaths.isEmpty) {
      await Share.share(
          titleController.text.isEmpty
              ? 'Keep notes make by Satvik'
              : titleController.text,
          subject: 'muje nahi pata',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void changecrossAxiscount() {
    switch (imagelist.length) {
      case 1:
        crossaxis = 1;
        break;
      case 2:
        crossaxis = 2;
        break;
      case 3:
        crossaxis = 3;
        break;
      case 4:
        crossaxis = 3;
        break;
    }
    notifyListeners();
  }

  List checkList = [];

  void addscreen() {
    ischeckscreen = true;

    notifyListeners();
  }

  void addReminder() {
    containerTextList.add(containertext);
    timeTextList.add(timetext);
    notifyListeners();
  }
}
