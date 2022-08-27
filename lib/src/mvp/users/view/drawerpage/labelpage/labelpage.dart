import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelpageprovider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/widget/bottombar/custombottombar.dart';
import 'package:provider_app/src/widget/customicon/customicon.dart';
import 'package:provider_app/src/widget/drawer/drawer.dart';
import 'package:provider_app/utilities/utilities.dart';

class LabelPageScreen extends StatefulWidget {
  int index;
  LabelPageScreen({required this.index, Key? key}) : super(key: key);

  @override
  State<LabelPageScreen> createState() => _LabelPageScreenState();
}

class _LabelPageScreenState extends State<LabelPageScreen> {
  var drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      key: drawerKey,
      drawer: CustomDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Consumer<LabelProvider>(builder: (context, labelProvider, child) {
                return Consumer<LabelPageProvider>(
                    builder: (context, provider, child) {
                  return labelProvider.labelRow.isEmpty
                      ? Text('No data')
                      : Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  drawerKey.currentState!.openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  color: VariableUtilities.theme.drawerColor,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: 200,
                                  height: 25,
                                  child: Text(
                                    labelProvider
                                        .textController[widget.index + 1],
                                    style: FontUtilities.h20(
                                        fontColor: VariableUtilities
                                            .theme.keeptextColor),
                                  ),
                                ),
                              ),
                            ),
                            // const Spacer(),
                            const SizedBox(
                              width: 4,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search,
                                  color: VariableUtilities.theme.keeptextColor,
                                )),
                            const CustomIcon(),
                            const SizedBox(
                              width: 4,
                            ),
                            PopupMenuButton(
                              onSelected: (value) {
                                if (value == 1) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        TextEditingController _controller =
                                            TextEditingController(
                                                text:
                                                    Provider.of<LabelProvider>(
                                                                context)
                                                            .textController[
                                                        widget.index + 1]);
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: VariableUtilities
                                              .theme.backgroundColor,
                                          title: Text(
                                            'Rename label',
                                            style: FontUtilities.h16(
                                                fontColor: VariableUtilities
                                                    .theme.keeptextColor),
                                          ),
                                          content: TextFormField(
                                            controller: _controller,
                                            style: FontUtilities.h18(
                                                fontColor: VariableUtilities
                                                    .theme.keeptextColor),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        const StadiumBorder()),
                                                onPressed: () {
                                                  Provider.of<LabelProvider>(
                                                          context,
                                                          listen: false)
                                                      .updateinitialvalue(
                                                    _controller.text,
                                                    widget.index,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Rename'))
                                          ],
                                        );
                                      });
                                } else if (value == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: VariableUtilities
                                              .theme.backgroundColor,
                                          title: Text(
                                            'Delete label?',
                                            style: FontUtilities.h24(
                                                fontColor: VariableUtilities
                                                    .theme.keeptextColor),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "We'll delete this label and remove if from all of your keep notes.Your notes won't be deleted.",
                                                style: FontUtilities.h16(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              )
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  Provider.of<LabelProvider>(
                                                          context,
                                                          listen: false)
                                                      .ondeleteButton1(
                                                          widget.index);
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedIndex1 = null;
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          RouteUtilities
                                                              .userScreen,
                                                          (route) => false);
                                                },
                                                child: const Text('Delete')),
                                          ],
                                        );
                                      });
                                }
                              },
                              icon: Icon(
                                Icons.more_vert_outlined,
                                color: VariableUtilities.theme.keeptextColor,
                              ),
                              color: VariableUtilities.theme.backgroundColor,
                              itemBuilder: ((context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 1,
                                    child: Text(
                                      'Rename label',
                                      style: FontUtilities.h16(
                                          fontColor: VariableUtilities
                                              .theme.keeptextColor),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    onTap: () {},
                                    child: Text(
                                      'Delete label',
                                      style: FontUtilities.h16(
                                          fontColor: VariableUtilities
                                              .theme.keeptextColor),
                                    ),
                                  ),
                                ];
                              }),
                            )
                          ],
                        );
                });
              }),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Icon(
                    Icons.label_outline,
                    size: 150,
                    color: VariableUtilities.theme.bulbColor,
                  ),
                  Text(
                    'No notes with this label yet',
                    style: FontUtilities.h14(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
