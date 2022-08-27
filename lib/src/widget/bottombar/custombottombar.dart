// ignore_for_file: public_member_api_docs, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/recorderprovider.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/takingpic_alertdialog.dart';
import 'package:provider_app/utilities/utilities.dart';

Widget CustomBottomSheet(BuildContext context) {
  return Consumer(builder: (context, provider, child) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.check_box_outlined,
              color: VariableUtilities.theme.keeptextColor),
          onPressed: () {
            Provider.of<AddScreenProvider>(context, listen: false)
                .onbackarrow(context);

            Navigator.pushNamed(
              context,
              RouteUtilities.addnotesScreen,
            );
          },
        ),
        Consumer<BrushProvider>(builder: (context, provider, child) {
          return IconButton(
            icon: Icon(
              Icons.brush_rounded,
              color: VariableUtilities.theme.keeptextColor,
            ),
            onPressed: () {
              provider.whitebackground();
              provider.oncleartap(context);
              Provider.of<AddScreenProvider>(context, listen: false)
                  .onbackarrow(context);
              Provider.of<AddScreenProvider>(context, listen: false)
                  .addscreen();
              Navigator.pushNamed(context, RouteUtilities.brushScreen);
            },
          );
        }),
        Consumer<RecorderProvider>(builder: (context, provider, child) {
          return IconButton(
            icon: Icon(
              Icons.keyboard_voice_outlined,
              color: VariableUtilities.theme.keeptextColor,
            ),
            onPressed: () {
              provider.askethepermissionforrecording(context);
              Provider.of<AddScreenProvider>(context, listen: false)
                  .onbackarrow(context);
            },
          );
        }),
        IconButton(
          icon: Icon(
            Icons.photo,
            color: VariableUtilities.theme.keeptextColor,
          ),
          onPressed: () {
            Provider.of<AddScreenProvider>(context, listen: false)
                .onbackarrow(context);
            showDialog(
                context: context,
                builder: (context) {
                  return const TakePicDailog();
                });
          },
        ),
      ],
    );
  });
}

Widget customFloatingButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: VariableUtilities.theme.searchColor,
    shape: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
    onPressed: () {
      Navigator.pushNamed(context, RouteUtilities.addnotesScreen);
      Provider.of<AddScreenProvider>(context, listen: false)
          .onbackarrow(context);

      ischeckscreen = true;
    },
    child: Icon(
      Icons.add,
      color: VariableUtilities.theme.keeptextColor,
    ),
  );
}
