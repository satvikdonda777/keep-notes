// ignore_for_file: duplicate_ignore, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/widget/drawer/drawer.dart';
import 'package:provider_app/src/widget/homescreen/checknotelist.dart';

import 'package:provider_app/utilities/utilities.dart';

class DeletedPage extends StatefulWidget {
  const DeletedPage({Key? key}) : super(key: key);

  @override
  State<DeletedPage> createState() => _DeletedPageState();
}

class _DeletedPageState extends State<DeletedPage> {
  var drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: VariableUtilities.theme.backgroundColor,
      drawer: CustomDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Row(
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
                  width: 6,
                ),
                Text(
                  'Deleted',
                  style: FontUtilities.h20(
                      fontColor: VariableUtilities.theme.keeptextColor),
                ),
                const Spacer(),
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
                          child: Text('Empty Recycle Bin',
                              style: FontUtilities.h16(
                                fontColor:
                                    VariableUtilities.theme.keeptextColor,
                              ))),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 1) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor:
                                  VariableUtilities.theme.backgroundColor,
                              title: Text(
                                'Empty Recycle Bin?',
                                style: FontUtilities.h22(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor,
                                  fontWeight: FWT.semiBold,
                                ),
                              ),
                              content: Text(
                                'All notes in Recycle Bin will be permanently deleted',
                                style: FontUtilities.h14(
                                    fontColor:
                                        VariableUtilities.theme.keeptextColor,
                                    fontWeight: FWT.light),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .deleteAllData();
                                    },
                                    child: const Text('Empty Recycle Bin')),
                              ],
                            );
                          });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<CategoryProvider>(builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: provider.deletedItemList.isNotEmpty
                    ? StaggeredGrid.count(
                        crossAxisCount:
                            provider.deletedItemList.length == 1 ? 1 : 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 4,
                        children: List.generate(provider.deletedItemList.length,
                            (index) {
                          return CheckNotesList(
                              index: index,
                              model: provider.deletedItemList[index],
                              provider: provider);
                        }),
                      )
                    : Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 170,
                            ),
                            Icon(
                              Icons.delete_outline_outlined,
                              color: VariableUtilities.theme.bulbColor,
                              size: 200,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'No notes in Recycle Bin',
                              style: FontUtilities.h18(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor),
                            )
                          ],
                        ),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
