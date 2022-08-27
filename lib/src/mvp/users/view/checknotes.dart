// ignore_for_file: lines_longer_than_80_chars, prefer_single_quotes, public_member_api_docs, unnecessary_null_comparison, prefer_if_null_operators, always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/model/categorymodel/categorymodel.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/recorderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/mvp/users/view/imagepage/images.dart';
import 'package:provider_app/src/widget/customrow/row.dart';
import 'package:provider_app/src/widget/customsnackbar/customsnackbar.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/customdialog.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/recorderdialog.dart';

import 'package:provider_app/utilities/utilities.dart';

// final data1 = ListTileData(textEditingController: TextEditingController());
ListTileData data = ListTileData(textEditingController: textEditingController);

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen(
      {Key? key,
      this.isEditMode = false,
      this.categoryModel,
      required this.index})
      : super(key: key);
  final bool isEditMode;
  final CategoryModel? categoryModel;
  final int? index;

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).indexs != null
        ? Fluttertoast.showToast(msg: 'Deleted notes not edited')
        : null;

    if (widget.isEditMode) {
      var checkProvider =
          Provider.of<AddScreenProvider>(context, listen: false);
      checkProvider.titleController.text = widget.categoryModel!.titel!;
      checkProvider.notesController.text =
          widget.categoryModel!.notesController!;
      checkProvider.imagelist = widget.categoryModel!.imageList!;
      checkProvider.icon = widget.categoryModel!.reminderIcon == null
          ? null
          : widget.categoryModel!.reminderIcon;
      checkProvider.containertext =
          widget.categoryModel!.reminderText!.isNotEmpty
              ? widget.categoryModel!.reminderText!
              : '';
      checkProvider.selectedTile = widget.categoryModel!.selectedTile;
      checkProvider.timetext =
          widget.categoryModel!.reminderTimeText!.isNotEmpty
              ? widget.categoryModel!.reminderTimeText
              : '';
      checkProvider.selectedColor = widget.categoryModel!.colorSelected!;
      checkProvider.containerwidth = widget.categoryModel!.reminderwidth;
      checkProvider.selectedTile = widget.categoryModel!.selectedTile;
      checkProvider.selectedbackgroundimage =
          widget.categoryModel!.selectedimage;
      checkProvider.imageurl = (widget.categoryModel!.backgroundImage != null
          ? widget.categoryModel!.backgroundImage!
          : null);
      Provider.of<RecorderProvider>(context, listen: false).path =
          widget.categoryModel!.path == null
              ? null
              : widget.categoryModel!.path;
      Provider.of<RecorderProvider>(context, listen: false).duration =
          (widget.categoryModel!.duration != null
              ? widget.categoryModel!.duration!
              : null)!;
      checkProvider.colorslist[checkProvider.selectedColor] =
          widget.categoryModel!.color!;
      checkProvider.crossaxis = widget.categoryModel!.crossCount!;
      checkProvider.rowList = widget.categoryModel!.rawList!;
    }

    tabController =
        TabController(length: 2, vsync: this, initialIndex: initialindex);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AddScreenProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () async {
          if (widget.isEditMode) {
            Provider.of<CategoryProvider>(
              context,
            ).updateData(context, provider, widget.categoryModel!);
          } else {
            if (provider.titleController.text.isNotEmpty ||
                provider.rowList.length > 1 ||
                provider.containertext!.isNotEmpty ||
                Provider.of<RecorderProvider>(context, listen: false).path !=
                    null ||
                provider.imagelist.isNotEmpty ||
                provider.selectedTile != null ||
                provider.notesController.text.isNotEmpty) {
              Provider.of<CategoryProvider>(context, listen: false).addCheckNotesData(
                  context,
                  notesControllertext: provider.notesController.text.isNotEmpty
                      ? provider.notesController.text
                      : '',
                  path: Provider.of<RecorderProvider>(context, listen: false).path != null
                      ? Provider.of<RecorderProvider>(context, listen: false)
                          .path
                      : null,
                  colorSelected: provider.selectedColor,
                  durationText:
                      Provider.of<RecorderProvider>(context, listen: false)
                                  .duration ==
                              null
                          ? null
                          : Provider.of<RecorderProvider>(context, listen: false)
                              .duration,
                  titel: provider.titleController.text.isNotEmpty
                      ? provider.titleController.text
                      : '',
                  iconData: Icons.check_box_outline_blank,
                  imageList: provider.imagelist,
                  reminderIcon: provider.icon,
                  crossCount: provider.crossaxis,
                  reminderText: provider.containertext,
                  selectedTile: provider.selectedTile,
                  reminderColor: provider.selectedTile == null ||
                          provider.selectedTile == 4
                      ? VariableUtilities.theme.transparent
                      : VariableUtilities.theme.keeptextColor.withOpacity(0.2),
                  reminderTimeText: provider.timetext,
                  selectedImage: provider.selectedbackgroundimage,
                  reminderwidth: provider.containerwidth,
                  rawList: provider.rowList,
                  backgroundImage: provider.imageurl,
                  checkScreen: ischeckscreen,
                  color: provider.colorslist[provider.selectedColor]);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(MyCustomSnackbar(
                  'Empty note discarded',
                  const TextButton(onPressed: null, child: Text(''))));
            }
          }
          return true;
        },
        child: Scaffold(
           key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: provider.colorslist[provider.selectedColor],
          body: Container(
            decoration: BoxDecoration(
              image: provider.imageurl == null
                  ? null
                  : DecorationImage(
                      image: AssetImage(
                        provider.imageurl!,
                      ),
                      fit: BoxFit.fill,
                    ),
            ),
            child: SafeArea(
              child: Consumer<AddScreenProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    Consumer<CategoryProvider>(
                        builder: (context, categoryProvider, child) {
                      return Row(
                        children: [
                          IconButton(
                              onPressed: Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .indexs !=
                                      null
                                  ? () {
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .selectedIndex = 0;
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RouteUtilities.userScreen,
                                          (route) => false);
                                    }
                                  : () {
                                      Provider.of<RecorderProvider>(context,
                                              listen: false)
                                          .audioPlayer
                                          .stop();

                                      if (widget.isEditMode) {
                                        categoryProvider.updateData(context,
                                            provider, widget.categoryModel!);
                                      } else {
                                        if (provider.titleController.text
                                                .isNotEmpty ||
                                            provider.rowList.length > 1 ||
                                            provider
                                                .containertext!.isNotEmpty ||
                                            Provider.of<RecorderProvider>(
                                                        context,
                                                        listen: false)
                                                    .path !=
                                                null ||
                                            provider.imagelist.isNotEmpty ||
                                            provider.selectedTile != null ||
                                            provider.notesController.text
                                                .isNotEmpty) {
                                          categoryProvider.addCheckNotesData(context,
                                              notesControllertext: provider
                                                      .notesController
                                                      .text
                                                      .isNotEmpty
                                                  ? provider
                                                      .notesController.text
                                                  : '',
                                              path: Provider.of<RecorderProvider>(context, listen: false).path != null
                                                  ? Provider.of<RecorderProvider>(context, listen: false)
                                                      .path
                                                  : null,
                                              colorSelected:
                                                  provider.selectedColor,
                                              durationText: Provider.of<RecorderProvider>(context, listen: false).duration == null
                                                  ? null
                                                  : Provider.of<RecorderProvider>(context, listen: false)
                                                      .duration,
                                              titel: provider.titleController
                                                      .text.isNotEmpty
                                                  ? provider.titleController.text
                                                  : '',
                                              iconData: Icons.check_box_outline_blank,
                                              imageList: provider.imagelist,
                                              reminderIcon: provider.icon,
                                              crossCount: provider.crossaxis,
                                              reminderText: provider.containertext,
                                              selectedTile: provider.selectedTile,
                                              reminderColor: provider.selectedTile == null || provider.selectedTile == 4 ? VariableUtilities.theme.transparent : VariableUtilities.theme.keeptextColor.withOpacity(0.2),
                                              reminderTimeText: provider.timetext,
                                              selectedImage: provider.selectedbackgroundimage,
                                              reminderwidth: provider.containerwidth,
                                              rawList: provider.rowList,
                                              backgroundImage: provider.imageurl,
                                              checkScreen: ischeckscreen,
                                              color: provider.colorslist[provider.selectedColor].withOpacity(0.4));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(MyCustomSnackbar(
                                                  'Empty note discarded',
                                                  const TextButton(
                                                      onPressed: null,
                                                      child: Text(''))));
                                        }
                                      }
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .storeLocalData();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RouteUtilities.userScreen,
                                          (route) => false);
                                    },
                              icon: Icon(
                                Icons.arrow_back,
                                color: VariableUtilities.theme.keeptextColor,
                              )),
                          const Spacer(),
                          IgnorePointer(
                            ignoring: Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .indexs !=
                                    null
                                ? true
                                : false,
                            child: IconButton(
                                onPressed: () {
                                  provider.toggleIcon();
                                },
                                icon: provider.isSelected
                                    ? Icon(
                                        Icons.push_pin,
                                        color: VariableUtilities
                                            .theme.keeptextColor,
                                      )
                                    : Icon(
                                        Icons.push_pin_outlined,
                                        color: VariableUtilities
                                            .theme.keeptextColor,
                                      )),
                          ),
                          IgnorePointer(
                            ignoring: Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .indexs !=
                                    null
                                ? true
                                : false,
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: provider
                                          .colorslist[provider.selectedColor],
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  provider.showContainer(
                                                      0, context);
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                title: Text(
                                                  "Later today",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                                trailing: Text(
                                                  "6:00 pm",
                                                  style: FontUtilities.h16(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  provider.showContainer(
                                                      1, context);
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                title: Text(
                                                  "Tomorrow morning",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                                trailing: Text(
                                                  "8:00 pm",
                                                  style: FontUtilities.h16(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  provider.showContainer(
                                                      2, context);
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                title: Text(
                                                  "Tuesday morning",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                                trailing: Text(
                                                  "Tue 8:00 am",
                                                  style: FontUtilities.h16(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  provider.showContainer(
                                                      3, context);
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(
                                                  Icons.home_filled,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                title: Text(
                                                  "Home",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  provider.showContainer(
                                                      4, context);
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(
                                                  Icons.work,
                                                  color: Colors.grey.shade700,
                                                ),
                                                title: Text(
                                                  "Work",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          Colors.grey.shade700),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  provider.showdialog(context);

                                                  provider.showContainer(
                                                      5, context);
                                                },
                                                leading: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                title: Text(
                                                  "Choose a date & time",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  provider.showdialog1(context);
                                                },
                                                leading: Icon(
                                                  Icons.location_on_outlined,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                title: Text(
                                                  "Choose a place",
                                                  style: FontUtilities.h20(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                                trailing: Text(
                                                  "6:00 pm",
                                                  style: FontUtilities.h16(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.notification_add_outlined,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                          ),
                          IgnorePointer(
                            ignoring: Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .indexs !=
                                    null
                                ? true
                                : false,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(MyCustomSnackbar(
                                          'Note archived',
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Undo',
                                                style: FontUtilities.h16(
                                                    fontColor: Colors.blue),
                                              ))));
                                },
                                icon: Icon(
                                  Icons.archive_outlined,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                          ),
                        ],
                      );
                    }),
                    Expanded(
                      child: SingleChildScrollView(
                        child: IgnorePointer(
                          ignoring: Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .indexs !=
                                  null
                              ? true
                              : false,
                          child: Column(
                            children: [
                              provider.imagelist.isNotEmpty
                                  ? Consumer<AddScreenProvider>(
                                      builder: (context, provider, child) {
                                      return GridView.builder(
                                        padding: const EdgeInsets.all(10),
                                        shrinkWrap: true,
                                        itemCount: provider.imagelist.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    provider.crossaxis,
                                                crossAxisSpacing: 2,
                                                mainAxisSpacing: 2,
                                                childAspectRatio: 1),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              provider.initialIndex = index;
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ImagePage(index: index);
                                              }));
                                            },
                                            child: Consumer<AddScreenProvider>(
                                                builder:
                                                    (context, provider, child) {
                                              return Image.file(
                                                provider.imagelist[index],
                                                fit: BoxFit.fill,
                                              );
                                            }),
                                          );
                                        },
                                      );
                                    })
                                  : const SizedBox.shrink(),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: TextFormField(
                                  controller: provider.titleController,
                                  style: FontUtilities.h20(
                                      fontWeight: FWT.regular,
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                  decoration: InputDecoration(
                                      suffixIcon: ischeckscreen == false
                                          ? Consumer<AddScreenProvider>(builder:
                                              (context, provider, child) {
                                              return PopupMenuButton(
                                                onSelected: (value) {
                                                  if (value == 1) {
                                                    provider.addscreen();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.more_vert_rounded,
                                                  color: VariableUtilities
                                                      .theme.keeptextColor,
                                                ),
                                                color: VariableUtilities
                                                    .theme.searchColor
                                                    .withOpacity(0.6),
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return [
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          provider.addscreen();
                                                        },
                                                        value: 1,
                                                        child: Text(
                                                          'Hide checkboxes',
                                                          style: FontUtilities.h16(
                                                              fontColor:
                                                                  VariableUtilities
                                                                      .theme
                                                                      .keeptextColor),
                                                        )),
                                                  ];
                                                },
                                              );
                                            })
                                          : null,
                                      border: InputBorder.none,
                                      hintText: 'Title',
                                      hintStyle: FontUtilities.h22(
                                          fontColor: VariableUtilities
                                              .theme.titlecolor)),
                                ),
                              ),
                              SizedBox(
                                height: ischeckscreen == false ? 10 : 0,
                              ),
                              ischeckscreen == false
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: provider.rowList.length,
                                      itemBuilder: (context, index) {
                                        return RowWidget(
                                          data: provider.rowList[index],
                                          onCheckBoxStateChange: (state) {
                                            provider.toggleselectedValue(
                                                state, index);
                                          },
                                          onDelete: () {
                                            provider.onclosebutton(index);
                                          },
                                        );
                                      })
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: TextFormField(
                                        maxLines: 70,
                                        minLines: 1,
                                        controller: provider.notesController,
                                        style: FontUtilities.h20(fontColor: VariableUtilities.theme.keeptextColor),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Note',
                                            hintStyle: FontUtilities.h22(
                                                fontColor:
                                                    Colors.grey.shade700)),
                                      ),
                                    ),
                              const SizedBox(
                                height: 8,
                              ),
                              ischeckscreen == false
                                  ? GestureDetector(
                                      onTap: () {
                                        provider.addRow();
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 45,
                                          ),
                                          Icon(
                                            Icons.add,
                                            color: VariableUtilities
                                                .theme.keeptextColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text("List item",
                                              style: FontUtilities.h18(
                                                fontColor: VariableUtilities
                                                    .theme.keeptextColor,
                                              )),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              Provider.of<RecorderProvider>(context,
                                              listen: false)
                                          .path !=
                                      null
                                  ? const SizedBox(
                                      height: 26,
                                    )
                                  : const SizedBox.shrink(),
                              Consumer<RecorderProvider>(
                                  builder: (context, provider, child) {
                                return provider.path != null
                                    ? Container(
                                        height: 50,
                                        margin: const EdgeInsets.only(
                                            left: 12.0, right: 12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: VariableUtilities
                                                .theme.keeptextColor
                                                .withOpacity(0.3)),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                provider.listenRecording();
                                                provider.repeatStop();
                                              },
                                              child: Icon(
                                                provider.isPlaying
                                                    ? Icons
                                                        .pause_circle_filled_rounded
                                                    : Icons
                                                        .play_circle_filled_rounded,
                                                color: Colors.blue,
                                                size: 30,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: StatefulBuilder(
                                                  builder: (context, snapshot) {
                                                return Slider(
                                                  min: 0,
                                                  max: provider
                                                      .duration.inSeconds
                                                      .toDouble(),
                                                  value: provider
                                                      .position.inSeconds
                                                      .toDouble(),
                                                  onChanged: (val) async {
                                                    final position = Duration(
                                                        seconds: val.toInt());
                                                    await provider.audioPlayer
                                                        .seek(position);
                                                    provider.audioPlayer
                                                        .onPlayerComplete
                                                        .listen((event) {});
                                                  },
                                                );
                                              }),
                                            ),
                                            Text(formatTime(provider.duration)),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: ((context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Delete voice recording?',
                                                          style:
                                                              FontUtilities.h18(
                                                            fontColor:
                                                                VariableUtilities
                                                                    .theme
                                                                    .keeptextColor,
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              provider
                                                                  .deleteAudio();
                                                            },
                                                            child: const Text(
                                                                'Delete'),
                                                          ),
                                                        ],
                                                      );
                                                    }));
                                              },
                                              child: Icon(
                                                Icons.delete_outlined,
                                                color: VariableUtilities
                                                    .theme.keeptextColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),
                              const SizedBox(
                                height: 27,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 100.0),
                                child: GestureDetector(
                                  onTap: provider.selectedTile == null ||
                                          provider.selectedTile == 4
                                      ? null
                                      : () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomAlertDialog();
                                              });
                                        },
                                  child: Container(
                                    height: 35,
                                    width: provider.containerwidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: provider.selectedTile == null ||
                                                provider.selectedTile == 4
                                            ? VariableUtilities
                                                .theme.transparent
                                            : VariableUtilities
                                                .theme.keeptextColor
                                                .withOpacity(0.2)),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Icon(
                                          provider.icon,
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          provider.containertext!,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontUtilities.h18(
                                              fontColor: VariableUtilities
                                                  .theme.keeptextColor),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            provider.timetext.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: FontUtilities.h18(
                                                fontColor: VariableUtilities
                                                    .theme.keeptextColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IgnorePointer(
                          ignoring: Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .indexs !=
                                  null
                              ? true
                              : false,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor:
                                      VariableUtilities.theme.backgroundColor,
                                  context: context,
                                  builder: (
                                    BuildContext context,
                                  ) {
                                    return SizedBox(
                                      height: 225,
                                      child: Column(
                                        children:
                                            provider.addboxBottomsheet.map((
                                          e,
                                        ) {
                                          return Consumer<AddScreenProvider>(
                                              builder: (context, value, child) {
                                            return ListTile(
                                              onTap: () {
                                                if (e["index"] == 0) {
                                                  Navigator.pop(context);
                                                  provider
                                                      .requestCameraPermission(
                                                          context);
                                                } else if (e["index"] == 1) {
                                                  Navigator.pop(context);
                                                  provider
                                                      .requestStoragePermission(
                                                          context);
                                                } else if (e["index"] == 2) {
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(
                                                      context,
                                                      RouteUtilities
                                                          .brushScreen);
                                                } else if (e["index"] == 3) {
                                                  Navigator.pop(context);
                                                  Provider.of<RecorderProvider>(
                                                          context,
                                                          listen: false)
                                                      .askethepermissionforrecording(
                                                          context);
                                                }
                                              },
                                              title: Text(
                                                e["title"],
                                                style: FontUtilities.h18(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              ),
                                              leading: Icon(
                                                e["icon"],
                                                color: VariableUtilities
                                                    .theme.keeptextColor,
                                              ),
                                            );
                                          });
                                        }).toList(),
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(Icons.add_box_outlined),
                            color: VariableUtilities.theme.keeptextColor,
                          ),
                        ),
                        IgnorePointer(
                          ignoring: Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .indexs !=
                                  null
                              ? true
                              : false,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Consumer<AddScreenProvider>(
                                        builder: (context, provider, child) {
                                      return Container(
                                        height: 250,
                                        color: provider.imageurl == null
                                            ? provider.colorslist[
                                                    provider.selectedColor]
                                                .withOpacity(0.4)
                                            : provider
                                                .bottomsheetbackgroundColor,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                "Colour",
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    provider.colorslist.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          provider
                                                              .checkSelectedColor(
                                                                  index);
                                                        },
                                                        child: Container(
                                                          child: provider
                                                                      .selectedColor ==
                                                                  index
                                                              ? const Icon(
                                                                  Icons
                                                                      .check_circle_outline_outlined,
                                                                  size: 38,
                                                                  color: Colors
                                                                      .blue,
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 16,
                                                                  backgroundColor:
                                                                      provider.colorslist[
                                                                          index],
                                                                ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 35.0, left: 8),
                                              child: Text(
                                                "Background",
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: ListView.builder(
                                                itemCount:
                                                    provider.imageList.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          provider
                                                              .backgroundImagechange(
                                                                  index);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              border: Border.all(
                                                                  color: provider
                                                                              .selectedbackgroundimage ==
                                                                          index
                                                                      ? Colors
                                                                          .indigoAccent
                                                                      : Colors
                                                                          .transparent,
                                                                  width: 2)),
                                                          child: CircleAvatar(
                                                            radius: 38,
                                                            child: ClipOval(
                                                              child:
                                                                  Image.asset(
                                                                provider.imageList[
                                                                    index],
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            },
                            icon: const Icon(
                              Icons.color_lens_outlined,
                            ),
                            color: VariableUtilities.theme.keeptextColor,
                          ),
                        ),
                        const SizedBox(width: 50),
                        provider.titleController.text.isEmpty
                            ? IgnorePointer(
                                ignoring: Provider.of<CategoryProvider>(context,
                                                listen: false)
                                            .indexs !=
                                        null
                                    ? true
                                    : false,
                                child: Text(
                                  "Edited ${TimeOfDay.now().format(context)}",
                                  style: FontUtilities.h14(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                ),
                              )
                            : IgnorePointer(
                                ignoring: Provider.of<CategoryProvider>(context,
                                                listen: false)
                                            .indexs !=
                                        null
                                    ? true
                                    : false,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.undo_rounded),
                                      onPressed: () {
                                        provider.changeUndoIconColor();
                                      },
                                      color: provider.isundoSelected
                                          ? VariableUtilities
                                              .theme.keeptextColor
                                          : VariableUtilities.theme.searchColor,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.redo_rounded),
                                      onPressed: () {
                                        provider.changeUndoIconColor();
                                      },
                                      color: provider.isundoSelected
                                          ? VariableUtilities.theme.searchColor
                                          : VariableUtilities
                                              .theme.keeptextColor,
                                    ),
                                  ],
                                ),
                              ),
                        const Spacer(),
                        IgnorePointer(
                          ignoring: Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .indexs !=
                                  null
                              ? true
                              : false,
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor:
                                        VariableUtilities.theme.backgroundColor,
                                    context: context,
                                    builder: (
                                      BuildContext context,
                                    ) {
                                      return Container(
                                        height: 280,
                                        child: Column(
                                          children:
                                              provider.bottomsheetitem.map((
                                            e,
                                          ) {
                                            return ListTile(
                                              onTap: () {
                                                if (e["index"] == 0) {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          MyCustomSnackbar(
                                                              'Note moved to bin',
                                                              TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    'Undo',
                                                                    style: FontUtilities.h16(
                                                                        fontColor:
                                                                            Colors.blue),
                                                                  ))));
                                                } else if (e["index"] == 1) {
                                                } else if (e["index"] == 2) {
                                                  Navigator.pop(context);
                                                  provider
                                                      .onsendButton(context);
                                                } else if (e["index"] == 3) {
                                                  print("Pressed444444444");
                                                } else if (e["index"] == 4) {
                                                  print("Pressed555555555");
                                                }
                                              },
                                              title: Text(
                                                e["title"],
                                                style: FontUtilities.h18(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              ),
                                              leading: Icon(
                                                e["icon"],
                                                color: VariableUtilities
                                                    .theme.keeptextColor,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: VariableUtilities.theme.keeptextColor,
                              )),
                        )
                      ],
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}
