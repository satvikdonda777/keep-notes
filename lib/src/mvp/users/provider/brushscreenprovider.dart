// ignore_for_file: public_member_api_docs, avoid_print, deprecated_member_use, sort_constructors_first, always_declare_return_types, curly_braces_in_flow_control_structures, unused_element, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/utilities/asset/asset_utilities.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';

Color? selectedColor = Colors.black;
Color? selectedColor1 = Colors.black;
int? titleColorselectedindex = 0;

class BrushProvider extends ChangeNotifier {
  int selectedIndex = 2;

  double width = 3;
  void togglecontainer(int value) {
    selectedIndex = value;
    if (selectedIndex == 4) {
      selectedColor = selectedColor?.withOpacity(0.05);
      selectedColor1 = selectedColor1?.withOpacity(0.05);
      notifyListeners();
    } else {
      selectedColor = selectedColor?.withOpacity(1);
      selectedColor1 = selectedColor1?.withOpacity(1);
      notifyListeners();
    }
    if (selectedIndex == 1) {
      selectedColor = Colors.white;
      selectedColor1 = Colors.white;
      width = 30;
      notifyListeners();
    }
    notifyListeners();
  }

  List<Color> brushColorlist = [
    Colors.black,
    Colors.deepOrange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.blue,
    Colors.purpleAccent,
    Colors.brown.shade300
  ];
  List<Color> expansiotileColorList = [
    Colors.white,
    Colors.red.shade900,
    Colors.deepOrangeAccent.shade200,
    Colors.lightGreen.withOpacity(0.1),
    Colors.blue.shade500.withGreen(12),
    const Color.fromARGB(255, 60, 24, 66),
    Colors.brown.shade900,
    Colors.grey,
    Colors.redAccent,
    Colors.orange.shade900,
    Colors.lightGreen.shade500,
    Colors.indigo,
    Colors.indigoAccent.shade700,
    Colors.cyan,
    Colors.grey.shade300,
    Colors.pink.shade200,
    Colors.lightGreen.shade300,
    Colors.indigoAccent.shade100,
    Colors.purpleAccent.shade100,
    Colors.cyan.shade200,
    Colors.deepPurple.shade700
  ];

  int? colorselectedindex;

  void selectColor(index) {
    colorselectedindex = index;
    if (colorselectedindex != null) {
      titleColorselectedindex = null;
      if (titleColorselectedindex == null) {
        selectedColor = expansiotileColorList[index];
        if (selectedIndex == 4) {
          selectedColor = selectedColor?.withOpacity(0.1);
          selectedColor1 = selectedColor1?.withOpacity(0.1);
          notifyListeners();
        }
        selectedColor1 = null;
      }
    }
    notifyListeners();
  }

  void selecttitleColor(index1) {
    titleColorselectedindex = index1;
    if (titleColorselectedindex != null) {
      colorselectedindex = null;
      if (selectedIndex == 4) {
        selectedColor = selectedColor?.withOpacity(0.1);
        selectedColor1 = selectedColor1?.withOpacity(0.1);
        notifyListeners();
      }
      if (colorselectedindex == null) {
        selectedColor1 = brushColorlist[index1];
        if (selectedIndex == 4) {
          selectedColor = selectedColor?.withOpacity(0.1);
          selectedColor1 = selectedColor1?.withOpacity(0.1);
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  bool isFrombrushScreen = false;
  int circleSelected = 3;
  void checkCirlceselected(index) {
    circleSelected = index;
    if (selectedIndex == 4) {
      selectedColor = selectedColor?.withOpacity(0.1);
      selectedColor1 = selectedColor1?.withOpacity(0.1);

      notifyListeners();
    }

    if (circleSelected == 0) {
      width = 1;
    } else if (circleSelected == 1) {
      width = 4;
    } else if (circleSelected == 2) {
      width = 8;
    } else if (circleSelected == 3) {
      width = 11;
    } else if (circleSelected == 4) {
      width = 15;
    } else if (circleSelected == 5) {
      width = 19;
    } else if (circleSelected == 6) {
      width = 23;
    } else {
      width = 26;
    }
    notifyListeners();
  }

  List<DrawingPoints?> offset = [];
  void onpanStart(BuildContext context, details) {
    final renderbox = context.findRenderObject() as RenderBox;

    offset.add(DrawingPoints(
      points: renderbox.globalToLocal(details.globalPosition),
      paint: Paint()
        ..color =
            titleColorselectedindex == null ? selectedColor! : selectedColor1!
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = selectedIndex == 3 ? width * 1.5 : width,
    ));
    notifyListeners();
  }

  void onpanUpdate(BuildContext context, details) {
    final renderbox = context.findRenderObject() as RenderBox;

    offset.add(DrawingPoints(
      points: renderbox.globalToLocal(details.globalPosition),
      paint: Paint()
        ..color =
            titleColorselectedindex == null ? selectedColor! : selectedColor1!
        ..strokeCap = selectedIndex == 4 ? StrokeCap.square : StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = selectedIndex == 3 ? width * 1.5 : width,
    ));
    notifyListeners();
  }

  void onpanEnd(details) {
    offset.add(null);
    notifyListeners();
  }

  void oncleartap(BuildContext context) {
    offset.clear();
    Provider.of<CategoryProvider>(context, listen: false)
        .categorySelectedIndex = null;
    // Provider.of<AddScreenProvider>(context, listen: false).imagelist.clear();
    whitebackground();
    notifyListeners();
  }

  List<DrawingPoints?> deletedPoints = [];
  List<DrawingPoints?> revPoints = [];
  List<DrawingPoints?> dp = [];
  void undo() {
    int c = offset.where((element) => element == null).length;
    print('C LEN : $c');
    if (c <= 1) {
      offset.clear();
    } else {
      revPoints = offset.reversed.toList();
      if (revPoints.first == null) {
        revPoints.removeAt(0);
      }
      print('OFF LEN BEFORE : ${offset.length}');
      int index = revPoints.indexWhere((element) => element == null) + 1;
      print('INDEX : $index');
      List<DrawingPoints?> dp = revPoints.sublist(0, index);
      print('DP LEN : ${dp.length}');
      revPoints.removeRange(0, index);
      offset = revPoints.reversed.toList();
      offset.add(null);
      print('OFF LEN AFTER : ${offset.length}');
    }

    // }
    // if (c == 1 || c == 0) {
    //   offset.clear();
    // } else {
    //   revPoints = offset.reversed.toList();
    //   int i, count = 0;
    //   for (i = 0; i < revPoints.length; i++) {
    //     if (revPoints[i] == null) {
    //       count++;
    //       if (count == 2) break;
    //     }
    //   }
    //   for (int k = offset.length - i - 1; k < offset.length; k++) {
    //     deletedPoints.add(offset[k]);
    //   }
    //   offset.removeRange(offset.length - i - 1, offset.length - 1);
    // }
    notifyListeners();
  }

  void redo() {
    // int c = 0;
    // for (int k = 0; k < offset.length; k++) {
    //   if (offset[k] == null) {
    //     c++;

    //     notifyListeners();
    //   }
    // }
    // if (c == 1)
    //   for (int i = 0; i < dp.length; i++) {
    //     offset.add(dp[i]);
    //     notifyListeners();
    //   }
    // else {
    //   int count = 0, i;

    //   for (i = 0; i < dp.length; i++) {
    //     if (dp[i] == null) {
    //       count++;
    //       notifyListeners();
    //     }
    //     if (count == 2) break;
    //   }
    //   for (int j = dp.length - i - 1; j < dp.length; j++) {
    //     offset.add(dp[j]);
    //     notifyListeners();
    //   }
    //   dp.removeRange(dp.length - 1 - 1, dp.length - 1);
    //   notifyListeners();
    // }
    // revPoints.clear();
    // notifyListeners();
  }

  String backgroundImage = AssetUtilities.brushbackgroundimage4;
  int selectedbackgroundimage = 3;
  void onbrushbackgroundSelected(int val) {
    selectedbackgroundimage = val;

    notifyListeners();
  }

  void onAcceptButton() {
    if (selectedbackgroundimage == 0) {
      backgroundImage = AssetUtilities.brushbackgroundimage1;
    } else if (selectedbackgroundimage == 1) {
      backgroundImage = AssetUtilities.brushbackgroundimage3;
    } else if (selectedbackgroundimage == 2) {
      backgroundImage = AssetUtilities.brushbackgroundimage2;
    } else if (selectedbackgroundimage == 3) {
      backgroundImage = AssetUtilities.brushbackgroundimage4;
    }
    notifyListeners();
  }

  void whitebackground() {
    backgroundImage = AssetUtilities.brushbackgroundimage4;
    selectedbackgroundimage = 3;
    notifyListeners();
  }

  List<String> imagePaths = [];
  void onsendButton(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: 'hey bro',
          subject: 'I dont know',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share('hey bro',
          subject: 'muje nahi pata',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  // void addImage(BuildContext context) {
  //   if (ssImage != null) {
  //     Provider.of<AddScreenProvider>(context, listen: false).addImage(ssImage!);
  //     ischeckscreen = true;
  //     ssImage = null;
  //     notifyListeners();
  //   }
  // }
  void addImage(BuildContext context) {
    if (ssImage != null) {
      Provider.of<AddScreenProvider>(context, listen: false).addImage(ssImage!);
      notifyListeners();
    }
    notifyListeners();
  }

  GlobalKey previewContainer = GlobalKey();
  File? ssImage;
  Future<void> captureSocialPng(BuildContext context) {
    List<String> imagePaths = [];
    // ignore: unnecessary_new

    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/screenshot.png');
      ssImage = File('$directory/screenshot.png');
      imagePaths.add(imgFile.path);
      if (offset.isNotEmpty) {
        addImage(context);
        notifyListeners();
      }

      notifyListeners();
      await imgFile.writeAsBytes(pngBytes).then((value) async {
        // await Share.shareFiles(
        //   imagePaths,
        //   subject: 'Share',
        //   text: 'Check this Out!',
        // );
      }).catchError((onError) {
        print(onError);
      });
    });
  }

  Future<void> captureSocialPng1(BuildContext context) {
    List<String> imagePaths = [];
    // ignore: unnecessary_new

    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/screenshot.png');
      ssImage = File('$directory/screenshot.png');
      imagePaths.add(imgFile.path);

      notifyListeners();
      await imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(
          imagePaths,
          subject: 'Share',
          text: 'Check this Out!',
        );
      }).catchError((onError) {
        print(onError);
      });
    });
  }
}

class MyCustomPaint extends CustomPainter {
  MyCustomPaint(this.offsets) : super();

  List<DrawingPoints?> offsets;
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        canvas.drawLine(
            offsets[i]!.points!, offsets[i + 1]!.points!, offsets[i]!.paint!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingPoints {
  Paint? paint;
  Offset? points;
  DrawingPoints({this.points, this.paint});
}
