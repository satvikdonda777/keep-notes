import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/widget/customsnackbar/customsnackbar.dart';
import 'package:provider_app/src/widget/dialog/alertfialog.dart';
import 'package:provider_app/utilities/utilities.dart';

class BrushPopupMenuButton extends StatefulWidget {
  const BrushPopupMenuButton({Key? key}) : super(key: key);

  @override
  State<BrushPopupMenuButton> createState() => _BrushPopupMenuButtonState();
}

class _BrushPopupMenuButtonState extends State<BrushPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: VariableUtilities.theme.searchColor,
      icon: Icon(
        Icons.more_vert_rounded,
        color: Colors.white,
      ),
      itemBuilder: ((context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Text(
              'Show grid',
              style: FontUtilities.h20(
                  fontColor: VariableUtilities.theme.keeptextColor),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              'Gradb image text',
              style: FontUtilities.h20(
                  fontColor: VariableUtilities.theme.keeptextColor),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Text(
              'Copy',
              style: FontUtilities.h20(
                  fontColor: VariableUtilities.theme.keeptextColor),
            ),
          ),
          PopupMenuItem(
            value: 4,
            child: Text(
              'Send',
              style: FontUtilities.h20(
                  fontColor: VariableUtilities.theme.keeptextColor),
            ),
          ),
          PopupMenuItem(
            value: 5,
            child: Text(
              'Delete',
              style: FontUtilities.h20(
                  fontColor: VariableUtilities.theme.keeptextColor),
            ),
          ),
        ];
      }),
      onSelected: (value) {
        if (value == 1) {
          showDialog(
              context: context,
              builder: (context) {
                return ShowAlertDailog(context);
              });
        } else if (value == 2) {
          if (Provider.of<BrushProvider>(context, listen: false)
              .offset
              .isEmpty) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                RouteUtilities.addnotesScreen,
                ModalRoute.withName(RouteUtilities.addnotesScreen));
            Provider.of<AddScreenProvider>(context, listen: false).addscreen();
            ScaffoldMessenger.of(context).showSnackBar(MyCustomSnackbar(
                'Empty drawing discarded',
                const TextButton(onPressed: null, child: Text(''))));
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteUtilities.addnotesScreen, (route) => false);
          }
        } else if (value == 3) {
        } else if (value == 4) {
          Provider.of<BrushProvider>(context, listen: false)
              .captureSocialPng1(context);
        } else if (value == 5) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: VariableUtilities.theme.backgroundColor,
                  title: Text(
                    'Delete image?',
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          Provider.of<BrushProvider>(context, listen: false)
                              .offset
                              .clear();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteUtilities.addnotesScreen,
                              ModalRoute.withName(
                                  RouteUtilities.addnotesScreen));
                          Provider.of<AddScreenProvider>(context, listen: false)
                              .addscreen();
                        },
                        child: const Text('Delete')),
                  ],
                );
              });
        }
      },
    );
  }
}
