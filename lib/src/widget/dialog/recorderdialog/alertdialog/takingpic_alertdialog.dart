import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/route/route_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class TakePicDailog extends StatefulWidget {
  const TakePicDailog({Key? key}) : super(key: key);

  @override
  State<TakePicDailog> createState() => _TakePicDailogState();
}

class _TakePicDailogState extends State<TakePicDailog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      backgroundColor: VariableUtilities.theme.backgroundColor,
      title: Text(
        'Add a Image',
        style: FontUtilities.h22(
            fontColor: VariableUtilities.theme.keeptextColor,
            fontWeight: FWT.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                ischeckscreen = true;
                requestCameraPermission(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteUtilities.addnotesScreen);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_enhance_outlined,
                    color: VariableUtilities.theme.keeptextColor,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Take photo',
                    style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                ischeckscreen = true;

                requestStoragePermission(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteUtilities.addnotesScreen);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.photo,
                    color: VariableUtilities.theme.keeptextColor,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    'Choose image',
                    style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> requestCameraPermission(BuildContext context) async {
  final status = await Permission.camera.request();
  if (status == PermissionStatus.granted) {
    Provider.of<AddScreenProvider>(context, listen: false)
        .takephoto(ImageSource.camera, context);
  } else if (status == PermissionStatus.denied) {
    await requestCameraPermission(context);
  } else if (status == PermissionStatus.permanentlyDenied) {}
}

Future<void> requestStoragePermission(BuildContext context) async {
  final status = await Permission.storage.request();
  if (status == PermissionStatus.granted) {
    Provider.of<AddScreenProvider>(context, listen: false)
        .takephoto(ImageSource.gallery, context);
  } else if (status == PermissionStatus.denied) {
  } else if (status == PermissionStatus.permanentlyDenied) {}
}
