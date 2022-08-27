import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/reminderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/iconprovider/cusromicon_provider.dart';
import 'package:provider_app/src/widget/bottombar/custombottombar.dart';
import 'package:provider_app/src/widget/customicon/customicon.dart';
import 'package:provider_app/src/widget/customsnackbar/customsnackbar.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/colordialog/coloralertdialog.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/alertdialog/customdialog.dart';
import 'package:provider_app/src/widget/drawer/drawer.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/route/route_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  var drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: VariableUtilities.theme.backgroundColor,
      drawer: CustomDrawer(context),
      body: Consumer<AddScreenProvider>(builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Provider.of<ReminderProvider>(context).isLongPress
                ? Container()
                : const SizedBox(
                    height: 40,
                  ),
            Consumer<ReminderProvider>(builder: (context, provider, child) {
              return provider.isLongPress
                  ? Container(
                      height: 90,
                      color:
                          VariableUtilities.theme.searchColor.withOpacity(0.4),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  provider.closeLongPress();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '1',
                              style: FontUtilities.h18(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.disposeLongPress();
                                },
                                icon: Icon(
                                  Icons.push_pin_outlined,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  provider.disposeLongPress();

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog();
                                      });
                                },
                                icon: Icon(
                                  Icons.notification_add_outlined,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  provider.disposeLongPress();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ColorAlertDialog();
                                      });
                                },
                                icon: Icon(
                                  Icons.color_lens_outlined,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  provider.disposeLongPress();
                                },
                                icon: Icon(
                                  Icons.label_outline,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: VariableUtilities.theme.keeptextColor,
                              ),
                              color: VariableUtilities.theme.backgroundColor,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        'Archive',
                                        style: FontUtilities.h14(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: Text(
                                        'Delete',
                                        style: FontUtilities.h14(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      )),
                                  PopupMenuItem(
                                      value: 3,
                                      child: Text(
                                        'Make a copy',
                                        style: FontUtilities.h14(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      )),
                                  PopupMenuItem(
                                      value: 4,
                                      child: Text(
                                        'Send',
                                        style: FontUtilities.h14(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      )),
                                  PopupMenuItem(
                                      value: 5,
                                      child: Text(
                                        'Copy to Google Docs',
                                        style: FontUtilities.h14(
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
                                                onPressed: () {},
                                                child: const Text(
                                                  'Undo',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.indigoAccent),
                                                ))));
                                    provider.disposeLongPress();
                                    break;
                                  case 2:
                                    provider.disposeLongPress();
                                    Provider.of<AddScreenProvider>(context,
                                            listen: false)
                                        .timeTextList
                                        .clear();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                            onPressed: () {
                              drawerKey.currentState!.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              size: 26,
                              color: VariableUtilities.theme.drawerColor,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Reminders',
                          style: FontUtilities.h18(
                              fontColor: VariableUtilities.theme.keeptextColor),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: VariableUtilities.theme.drawerColor,
                            )),
                        const CustomIcon(),
                        const SizedBox(
                          width: 12,
                        )
                      ],
                    );
            }),
            const SizedBox(
              height: 15,
            ),
            Consumer<AddScreenProvider>(builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Provider.of<AddScreenProvider>(context, listen: false)
                            .containerTextList
                            .isEmpty ||
                        Provider.of<AddScreenProvider>(context, listen: false)
                            .timeTextList
                            .isEmpty
                    ? Container()
                    : Text(
                        'Upcoming',
                        style: FontUtilities.h14(
                            fontColor: VariableUtilities.theme.keeptextColor),
                      ),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Provider.of<AddScreenProvider>(context, listen: false)
                        .timeTextList
                        .isEmpty ||
                    Provider.of<AddScreenProvider>(context, listen: false)
                        .timeTextList
                        .isEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 4),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 6),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: VariableUtilities.theme.bulbColor,
                          size: 140,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text(
                          'Notes with upcoming reminders appear here',
                          style: FontUtilities.h14(
                              fontColor: VariableUtilities.theme.keeptextColor),
                        ),
                      )
                    ],
                  )
                : Consumer<ReminderProvider>(
                    builder: (context, provider, child) {
                    return Expanded(
                      child: StaggeredGrid.count(
                        crossAxisCount: Provider.of<CustomIconProvider>(context,
                                    listen: false)
                                .isSelected
                            ? 2
                            : 1,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children: List.generate(
                            Provider.of<AddScreenProvider>(context,
                                    listen: false)
                                .containerTextList
                                .length, (index) {
                          return Consumer<AddScreenProvider>(
                              builder: (context, provider, child) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 20),
                              child: GestureDetector(
                                onLongPress: () {
                                  Provider.of<ReminderProvider>(context,
                                          listen: false)
                                      .onLongPress();
                                },
                                onTap: () {
                                  if (Provider.of<ReminderProvider>(context,
                                          listen: false)
                                      .isLongPress) {
                                    Provider.of<ReminderProvider>(context,
                                            listen: false)
                                        .disposeLongPress();
                                  } else {
                                    Navigator.pushNamed(
                                        context, RouteUtilities.addnotesScreen);
                                  }
                                },
                                child: Container(
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color:
                                        Provider.of<AddScreenProvider>(context)
                                            .colorslist[
                                                Provider.of<AddScreenProvider>(
                                                        context)
                                                    .selectedColor]
                                            .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Provider.of<ReminderProvider>(
                                          context,
                                        ).isLongPress
                                            ? Colors.indigo.shade400
                                            : Colors.grey,
                                        width: Provider.of<ReminderProvider>(
                                          context,
                                        ).isLongPress
                                            ? 3
                                            : 2),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, top: 12),
                                        child: Expanded(
                                          child: Text(
                                            'Reminder at ${Provider.of<AddScreenProvider>(context, listen: false).timeTextList[index]}',
                                            overflow: TextOverflow.ellipsis,
                                            style: FontUtilities.h16(
                                                fontColor: VariableUtilities
                                                    .theme.keeptextColor),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 20),
                                        child: Container(
                                          height: 35,
                                          width: provider.containerwidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: provider.selectedTile ==
                                                          null ||
                                                      provider.selectedTile ==
                                                          4 ||
                                                      provider.selectedTile ==
                                                          5 ||
                                                      provider.selectedTile == 6
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
                                              Expanded(
                                                child: Text(
                                                  '${provider.containerTextList[index]}${provider.timeTextList[index]}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: FontUtilities.h16(
                                                      fontColor:
                                                          VariableUtilities
                                                              .theme
                                                              .keeptextColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        }),
                      ),
                    );
                  }),
          ],
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
    );
  }
}
