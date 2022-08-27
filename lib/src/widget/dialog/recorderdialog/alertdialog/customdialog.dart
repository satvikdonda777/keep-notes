import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/notification/user_notification.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/utilities/utilities.dart';

class CustomAlertDialog extends StatefulWidget {
  CustomAlertDialog({Key? key}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    tabController =
        TabController(length: 2, vsync: this, initialIndex: initialindex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: VariableUtilities.theme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Text(
          'Edit reminder',
          style: FontUtilities.h24(
              fontColor: VariableUtilities.theme.keeptextColor),
        ),
        content: Container(
          height: 297,
          width: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              DefaultTabController(
                initialIndex: initialindex,
                length: 2,
                child: TabBar(
                  controller: tabController,
                  isScrollable: false,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontSize: 18),
                  unselectedLabelColor: Colors.grey.shade600,
                  labelColor: Colors.blue.shade400,
                  tabs: const [
                    Tab(
                      text: 'Time',
                    ),
                    Tab(
                      text: 'Place',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<AddScreenProvider>(
                              builder: (context, provider, child) {
                            return DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  provider.hintText,
                                  style: FontUtilities.h20(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                ),
                              ),
                              isExpanded: true,
                              dropdownColor:
                                  VariableUtilities.theme.backgroundColor,
                              underline: Divider(
                                thickness: 0.5,
                                color: VariableUtilities.theme.keeptextColor,
                              ),
                              style: FontUtilities.h20(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor),
                              value: provider.dropdownvalue,
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: VariableUtilities.theme.keeptextColor,
                                ),
                              ),
                              items: provider.items.map((items) {
                                return DropdownMenuItem(
                                  onTap: () {},
                                  alignment: Alignment.topLeft,
                                  value: items,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items,
                                        style: FontUtilities.h18(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      ),
                                      Container(
                                        height: 0.8,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: VariableUtilities
                                              .theme.keeptextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                provider.onchanged(value, context);
                              },
                            );
                          }),
                          Consumer<AddScreenProvider>(
                              builder: (context, provider, child) {
                            return DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  provider.hintText1,
                                  style: FontUtilities.h20(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                ),
                              ),
                              isExpanded: true,
                              dropdownColor:
                                  VariableUtilities.theme.backgroundColor,
                              underline: Divider(
                                thickness: 0.5,
                                color: VariableUtilities.theme.keeptextColor,
                              ),
                              style: FontUtilities.h20(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor),
                              value: provider.dropdownvalue1,
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: VariableUtilities.theme.keeptextColor,
                                ),
                              ),
                              items: provider.dropitem.map((items) {
                                return DropdownMenuItem(
                                    alignment: Alignment.topLeft,
                                    value: items,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              items['title'],
                                              style: FontUtilities.h18(
                                                  fontColor: VariableUtilities
                                                      .theme.keeptextColor),
                                            ),
                                            const Spacer(),
                                            Text(
                                              items['time'],
                                              style: FontUtilities.h18(
                                                  fontColor: VariableUtilities
                                                      .theme.keeptextColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          height: 0.8,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: VariableUtilities
                                                .theme.keeptextColor,
                                          ),
                                        ),
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                provider.onchanged1(value, context);
                              },
                            );
                          }),
                          Consumer<AddScreenProvider>(
                              builder: (context, provider, child) {
                            return DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  provider.hintText2,
                                  style: FontUtilities.h20(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                ),
                              ),
                              isExpanded: true,
                              dropdownColor:
                                  VariableUtilities.theme.backgroundColor,
                              style: FontUtilities.h20(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor),
                              value: provider.dropdownvalue,
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: VariableUtilities.theme.keeptextColor,
                                ),
                              ),
                              items: provider.drop2itmes.map((items) {
                                return DropdownMenuItem(
                                  onTap: () {},
                                  alignment: Alignment.topLeft,
                                  value: items,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items,
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: VariableUtilities
                                            .theme.keeptextColor,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                provider.onchanged2(value, context);
                              },
                            );
                          }),
                          const SizedBox(
                            height: 8,
                          ),
                          Consumer<AddScreenProvider>(
                              builder: (context, provider, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      provider.ondelete();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete')),
                                const SizedBox(
                                  width: 7,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                const SizedBox(
                                  width: 7,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(),
                                    onPressed: () {
                                      Navigator.pop(context);

                                      NotificationService
                                          .showScheduledNotification(
                                              id: 5,
                                              title:
                                                  provider.titleController.text,
                                              body: provider
                                                  .titleController.text);
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .addReminder(provider, context);
                                      provider.addReminder();
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .setReminder(context);
                                    },
                                    child: const Text('Save')),
                                const SizedBox(
                                  width: 7,
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Consumer<AddScreenProvider>(
                          builder: (context, provider, child) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.checkPlace();
                                  },
                                  child: Container(
                                    height: 23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Provider.of<AddScreenProvider>(
                                                      context)
                                                  .isSelectedPlace
                                              ? Colors.indigoAccent.shade100
                                              : VariableUtilities
                                                  .theme.keeptextColor,
                                          width: 3,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor:
                                            Provider.of<AddScreenProvider>(
                                                        context)
                                                    .isSelectedPlace
                                                ? Colors.indigoAccent.shade100
                                                : VariableUtilities
                                                    .theme.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.checkPlace();
                                  },
                                  child: Text(
                                    'Home',
                                    style: FontUtilities.h18(
                                        fontColor: VariableUtilities
                                            .theme.keeptextColor),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Surat',
                                  style: FontUtilities.h14(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                )
                              ],
                            ),
                            const SizedBox(height: 33),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade700,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Work',
                                  style: FontUtilities.h18(
                                      fontColor: Colors.grey.shade700),
                                )
                              ],
                            ),
                            const SizedBox(height: 33),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.checkPlace1();
                                  },
                                  child: Container(
                                    height: 23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Provider.of<AddScreenProvider>(
                                                      context)
                                                  .isSelectedPlace1
                                              ? Colors.indigoAccent.shade100
                                              : VariableUtilities
                                                  .theme.keeptextColor,
                                          width: 3,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor:
                                            Provider.of<AddScreenProvider>(
                                                        context)
                                                    .isSelectedPlace1
                                                ? Colors.indigoAccent.shade100
                                                : VariableUtilities
                                                    .theme.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Edite location',
                                  style: FontUtilities.h16(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      provider.ondelete();
                                    },
                                    child: const Text('Delete')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .addReminder(provider, context);
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .setReminder(context);
                                      NotificationService
                                          .showScheduledNotification(
                                              id: 5,
                                              title:
                                                  provider.titleController.text,
                                              body: provider
                                                  .titleController.text);
                                    },
                                    child: const Text('Save')),
                                const SizedBox(
                                  width: 7,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
