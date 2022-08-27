// ignore_for_file: prefer_single_quotes, lines_longer_than_80_chars, unawaited_futures, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/iconprovider/cusromicon_provider.dart';

import 'package:provider_app/src/mvp/users/provider/recorderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';

import 'package:provider_app/src/widget/bottombar/custombottombar.dart';
import 'package:provider_app/src/widget/customicon/customicon.dart';
import 'package:provider_app/src/widget/customsnackbar/customsnackbar.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/colordialog/coloralertdialog.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/customdialog.dart';
import 'package:provider_app/src/widget/drawer/drawer.dart';
import 'package:provider_app/src/widget/homescreen/checknotelist.dart';

import 'package:provider_app/utilities/utilities.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDialogOpen = false;
bool isEditScreen = false;

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  /// Constructor of user screen.

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String text = '';

  @override
  void initState() {
    setEmailText();
    RecorderProvider().onPlayerStateChanged();
    RecorderProvider().onAudioPositionChanged();
    RecorderProvider().onDurationChanged();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<CategoryProvider>(context, listen: false).getLocalData();
    // });
  }

  @override
  void dispose() {
    RecorderProvider().recorder.closeRecorder();
    RecorderProvider().audioPlayer.dispose();
    AddScreenProvider().titleController.dispose();
    AddScreenProvider().notesController.dispose();

    super.dispose();
  }

  Future setEmailText() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    text = sharedPreferences.getString('emailText').toString();
    setState(() {});
  }

  var drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey();
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                backgroundColor: VariableUtilities.theme.backgroundColor,
                title: Text(
                  'Do you realy want to exit??',
                  style: FontUtilities.h22(
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
                        Core.closeApplication();
                      },
                      child: const Text('Exit')),
                ],
              );
            });
        return true;
      },
      child: Scaffold(
        key: drawerKey,
        backgroundColor: VariableUtilities.theme.backgroundColor,
        drawer: CustomDrawer(context),
        body: Consumer<CategoryProvider>(builder: (context, provider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Consumer<CategoryProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<CategoryProvider>(
                        builder: (context, provider, child) {
                      return Provider.of<UserProvider>(context, listen: false)
                              .isLongPress
                          ? Container(
                              height: 60,
                              color: VariableUtilities.theme.searchColor
                                  .withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          provider.onTapClose(context);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .counter
                                          .toString(),
                                      style: FontUtilities.h18(
                                          fontColor: VariableUtilities
                                              .theme.keeptextColor),
                                    ),
                                    const Spacer(),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          provider.onTapClose(context);
                                        },
                                        icon: Icon(
                                          Icons.push_pin_outlined,
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          // provider.onTalClose(context);

                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomAlertDialog();
                                              });
                                        },
                                        icon: Icon(
                                          Icons.notification_add_outlined,
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          // provider.onTalClose(context);
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ColorAlertDialog();
                                              });
                                        },
                                        icon: Icon(
                                          Icons.color_lens_outlined,
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          provider.onTapClose(context);
                                        },
                                        icon: Icon(
                                          Icons.label_outline,
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        )),
                                    PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert_rounded,
                                        color: VariableUtilities
                                            .theme.keeptextColor,
                                      ),
                                      color: VariableUtilities
                                          .theme.backgroundColor,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                'Archive',
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              )),
                                          PopupMenuItem(
                                              value: 2,
                                              child: Text(
                                                'Delete',
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              )),
                                          PopupMenuItem(
                                              value: 3,
                                              child: Text(
                                                'Make a copy',
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              )),
                                          PopupMenuItem(
                                              value: 4,
                                              child: Text(
                                                'Send',
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              )),
                                          PopupMenuItem(
                                              value: 5,
                                              child: Text(
                                                'Copy to Google Docs',
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              )),
                                        ];
                                      },
                                      onSelected: (value) {
                                        switch (value) {
                                          case 1:
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(MyCustomSnackbar(
                                                    'Note archived',
                                                    TextButton(
                                                        onPressed: () {
                                                          provider
                                                              .undoArchive();
                                                        },
                                                        child: const Text(
                                                          'Undo',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .indigoAccent),
                                                        ))));
                                            provider.archiveData(context);

                                            break;
                                          case 2:
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(MyCustomSnackbar(
                                                    'Note deleted',
                                                    TextButton(
                                                        onPressed: () {
                                                          provider.undodelete();
                                                        },
                                                        child: const Text(
                                                          'Undo',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .indigoAccent),
                                                        ))));
                                            provider.deleteElement(context);
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12, top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteUtilities.searchScreen);
                                },
                                child: Container(
                                    height: 50,
                                    // width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color:
                                            VariableUtilities.theme.searchColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(children: [
                                      IconButton(
                                          onPressed: () {
                                            drawerKey.currentState!
                                                .openDrawer();
                                          },
                                          icon: Icon(
                                            Icons.menu,
                                            color: VariableUtilities
                                                .theme.drawerColor,
                                          )),
                                      AnimatedTextKit(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteUtilities.searchScreen);
                                        },
                                        animatedTexts: [
                                          WavyAnimatedText("Search your notes ",
                                              textStyle: FontUtilities.h18(
                                                fontColor: VariableUtilities
                                                        .theme is DarkTheme
                                                    ? Colors.white
                                                    : Colors.grey.shade800,
                                              ),
                                              speed: const Duration(
                                                  milliseconds: 200)),
                                        ],
                                        isRepeatingAnimation: false,
                                        repeatForever: false,
                                      ),
                                      const Spacer(),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 50.0),
                                          child: CustomIcon()),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 16,
                                            child: Text(
                                                text.isEmpty
                                                    ? 'D'
                                                    : text[0]
                                                        .toUpperCase()
                                                        .toString(),
                                                style: TextStyle(
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                )),
                                          ),
                                        ),
                                      )
                                    ])),
                              ));
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<CategoryProvider>(
                        builder: ((context, provider, child) {
                      return provider.allCategory.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: StaggeredGrid.count(
                                  crossAxisCount:
                                      Provider.of<CustomIconProvider>(
                                    context,
                                  ).isSelected
                                          ? 2
                                          : 1,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  children: List.generate(
                                      provider.allCategory.length, (index) {
                                    return GestureDetector(
                                      child: CheckNotesList(
                                        model: provider.allCategory[index],
                                        provider: provider,
                                        index: index,
                                      ),
                                    );
                                  })),
                            )
                          : const SizedBox.shrink();
                    })),
                    provider.allCategory.isEmpty
                        ? const SizedBox(
                            height: 780 / 4,
                          )
                        : const SizedBox.shrink(),
                    provider.allCategory.isEmpty
                        ? Center(
                            child: Icon(Icons.lightbulb_outline,
                                size: 170,
                                color: VariableUtilities.theme.bulbColor))
                        : SizedBox.fromSize(),
                    const SizedBox(
                      height: 15,
                    ),
                    provider.allCategory.isEmpty
                        ? Text("Notes you add apear here",
                            style: FontUtilities.h18(
                              fontColor: VariableUtilities.theme.keeptextColor,
                            ))
                        : const SizedBox.shrink()
                  ],
                );
              }),
            ),
          );
        }),
        bottomNavigationBar: BottomAppBar(
          color: VariableUtilities.theme.searchColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 7,
          child: CustomBottomSheet(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: customFloatingButton(context),
      ),
    );
  }
}
