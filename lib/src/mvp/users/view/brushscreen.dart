// ignore_for_file: prefer_single_quotes, lines_longer_than_80_chars, public_member_api_docs, avoid_unnecessary_containers, unused_field

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/src/widget/colorbottonsheet/brushcolorbottomsheet.dart';
import 'package:provider_app/src/widget/customsnackbar/customsnackbar.dart';

import 'package:provider_app/src/widget/popupmenu/brushpopup.dart';

import 'package:provider_app/utilities/utilities.dart';

class BrushScreen extends StatefulWidget {
  int? index;
  BrushScreen({this.index, Key? key}) : super(key: key);

  @override
  State<BrushScreen> createState() => _BrushScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _BrushScreenState extends State<BrushScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<AddScreenProvider>(context, listen: false)
            .isbackgroundImage = false;

        if (Provider.of<BrushProvider>(context, listen: false).offset.isEmpty) {
          Navigator.pushNamed(context, RouteUtilities.addnotesScreen);
          Provider.of<AddScreenProvider>(context, listen: false).addscreen();
          Provider.of<BrushProvider>(context, listen: false).isFrombrushScreen =
              true;
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(MyCustomSnackbar(
              'Empty drawing discarded',
              const TextButton(onPressed: null, child: Text(''))));
        } else {
          Provider.of<BrushProvider>(context, listen: false)
              .captureSocialPng(context);
          Navigator.pushNamedAndRemoveUntil(
              context, RouteUtilities.addnotesScreen, (route) => false);
          if (Provider.of<AddScreenProvider>(context, listen: false)
              .isbackgroundImage = false) {
            Provider.of<AddScreenProvider>(context, listen: false)
                    .imagelist[widget.index!] =
                Provider.of<BrushProvider>(context, listen: false).ssImage!;
          }
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 90,
              color: Colors.grey.shade800,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<AddScreenProvider>(context, listen: false)
                              .isbackgroundImage = false;
                          Provider.of<BrushProvider>(context, listen: false)
                              .captureSocialPng(context);
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteUtilities.addnotesScreen, (route) => false);
                          // if (Provider.of<BrushProvider>(context, listen: false)
                          //     .offset
                          //     .isEmpty) {
                          //   Navigator.pushNamed(
                          //       context, RouteUtilities.addnotesScreen);
                          //   Provider.of<AddScreenProvider>(context,
                          //           listen: false)
                          //       .addscreen();
                          //   Provider.of<BrushProvider>(context, listen: false)
                          //       .isFrombrushScreen = true;

                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       MyCustomSnackbar(
                          //           'Empty drawing discarded',
                          //           const TextButton(
                          //               onPressed: null, child: Text(''))));
                          // } else {
                          //   Provider.of<BrushProvider>(context, listen: false)
                          //       .captureSocialPng(context);
                          //   Navigator.pushNamedAndRemoveUntil(
                          //       context,
                          //       RouteUtilities.addnotesScreen,
                          //       (route) => false);
                          // if (Provider.of<AddScreenProvider>(context,
                          //         listen: false)
                          //     .isbackgroundImage = false) {
                          //   Provider.of<AddScreenProvider>(context,
                          //               listen: false)
                          //           .imagelist[widget.index!] =
                          //       Provider.of<BrushProvider>(context,
                          //               listen: false)
                          //           .ssImage!;
                          // }
                          // }
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Provider.of<BrushProvider>(context, listen: false)
                              .undo();
                        },
                        icon: const Icon(
                          Icons.undo_rounded,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          Provider.of<BrushProvider>(context, listen: false)
                              .redo();
                        },
                        icon: const Icon(Icons.redo_rounded,
                            color: Colors.white)),
                    const BrushPopupMenuButton(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer<BrushProvider>(
                builder: (context, provider, child) {
                  return Stack(
                    children: [
                      RepaintBoundary(
                        key: provider.previewContainer,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: Provider.of<AddScreenProvider>(context,
                                            listen: false)
                                        .isbackgroundImage
                                    ? FileImage(
                                        File(
                                          imagePaths[widget.index!],
                                        ),
                                      )
                                    : AssetImage(
                                        provider.backgroundImage,
                                      ) as ImageProvider,
                                fit: BoxFit.fill),
                          ),
                          height: MediaQuery.of(context).size.height - 150,
                          // width: MediaQuery.of(context).size.width,
                          child: PageView(
                            children: [
                              GestureDetector(
                                onPanStart: (details) {
                                  provider.onpanStart(context, details);
                                },
                                onPanUpdate: (details) {
                                  provider.onpanUpdate(context, details);
                                },
                                onPanEnd: (details) {
                                  provider.onpanEnd(details);
                                },
                                child: CustomPaint(
                                  painter: MyCustomPaint(provider.offset),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              color: Colors.grey.shade800,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                              backgroundColor:
                                  VariableUtilities.theme.backgroundColor,
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text("SELECT NONE"),
                                  ),
                                );
                              });
                        },
                        child: IconButton(
                            onPressed: () {
                              Provider.of<BrushProvider>(context, listen: false)
                                  .togglecontainer(0);
                            },
                            icon: const Icon(
                              Icons.photo_size_select_small,
                              color: Colors.white,
                            )),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                              backgroundColor:
                                  VariableUtilities.theme.backgroundColor,
                              context: context,
                              builder: (context) {
                                return Consumer<BrushProvider>(
                                    builder: (context, provider, child) {
                                  return Container(
                                    child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    VariableUtilities
                                                        .theme.backgroundColor,
                                                title: Text(
                                                  'This will clear all drawings from this spage.',
                                                  style: FontUtilities.h16(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        provider.oncleartap(
                                                            context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Clear'))
                                                ],
                                              );
                                            });
                                      },
                                      child: const Text("CLEAR CANVAS"),
                                    ),
                                  );
                                });
                              });
                        },
                        child: IconButton(
                            onPressed: () {
                              Provider.of<BrushProvider>(context, listen: false)
                                  .togglecontainer(1);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.white,
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            Provider.of<BrushProvider>(context, listen: false)
                                .togglecontainer(2);

                            showModalBottomSheet(
                                backgroundColor:
                                    VariableUtilities.theme.backgroundColor,
                                context: context,
                                builder: (context) {
                                  return const BrushColorScreen();
                                });
                          },
                          icon: const Icon(
                            Icons.mode_edit,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            Provider.of<BrushProvider>(context, listen: false)
                                .togglecontainer(3);

                            showModalBottomSheet(
                                backgroundColor:
                                    VariableUtilities.theme.backgroundColor,
                                context: context,
                                builder: (context) {
                                  return const BrushColorScreen();
                                });
                          },
                          icon: const Icon(
                            Icons.mode_edit_outlined,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            Provider.of<BrushProvider>(context, listen: false)
                                .togglecontainer(4);

                            showModalBottomSheet(
                                backgroundColor:
                                    VariableUtilities.theme.backgroundColor,
                                context: context,
                                builder: (context) {
                                  return const BrushColorScreen();
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 4,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Provider.of<BrushProvider>(context)
                                        .selectedIndex ==
                                    0
                                ? VariableUtilities.theme.keeptextColor
                                : VariableUtilities.theme.transparent),
                      ),
                      Container(
                        height: 4,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Provider.of<BrushProvider>(
                                      context,
                                    ).selectedIndex ==
                                    1
                                ? VariableUtilities.theme.keeptextColor
                                : VariableUtilities.theme.transparent),
                      ),
                      Container(
                        height: 4,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Provider.of<BrushProvider>(
                                      context,
                                    ).selectedIndex ==
                                    2
                                ? VariableUtilities.theme.keeptextColor
                                : VariableUtilities.theme.transparent),
                      ),
                      Container(
                        height: 4,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Provider.of<BrushProvider>(
                                      context,
                                    ).selectedIndex ==
                                    3
                                ? VariableUtilities.theme.keeptextColor
                                : VariableUtilities.theme.transparent),
                      ),
                      Container(
                        height: 4,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Provider.of<BrushProvider>(
                                      context,
                                    ).selectedIndex ==
                                    4
                                ? VariableUtilities.theme.keeptextColor
                                : VariableUtilities.theme.transparent),
                      ),
                    ],
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
