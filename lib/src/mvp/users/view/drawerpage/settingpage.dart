import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/settings_provider.dart';
import 'package:provider_app/src/mvp/users/provider/theme/themeprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/settingdialog/settingalertdialog.dart';

import 'package:provider_app/utilities/utilities.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: VariableUtilities.theme.backgroundColor,
        body: SafeArea(
          child:
              Consumer<SettingsProvider>(builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteUtilities.userScreen, (route) => false);
                          Provider.of<UserProvider>(context, listen: false)
                              .selectedIndex = 0;
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: VariableUtilities.theme.keeptextColor,
                        )),
                    Text(
                      'Settings',
                      style: FontUtilities.h18(
                          fontColor: VariableUtilities.theme.keeptextColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Display option',
                    style: FontUtilities.h14(fontColor: Colors.indigoAccent),
                  ),
                ),
                ListTile(
                  onTap: () {
                    provider.changeSwithValue1();
                  },
                  title: Text('Add new items to bottom',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Switch(
                    value: provider.isbuttonon1,
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.grey.shade300,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      provider.changeSwithValue1();
                    },
                  ),
                ),
                ListTile(
                  onTap: () {
                    provider.changeSwithValue2();
                  },
                  title: Text('Move ticked items to bottom',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Switch(
                    value: provider.isbuttonon2,
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.grey.shade300,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      provider.changeSwithValue2();
                    },
                  ),
                ),
                ListTile(
                  onTap: () {
                    provider.changeSwithValue3();
                  },
                  title: Text('Display rich link previews',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Switch(
                    value: provider.isbuttonon3,
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.grey.shade300,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      provider.changeSwithValue3();
                    },
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SettingDialog();
                        });
                  },
                  title: Text('Theme',
                      style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Text(Provider.of<ThemeChanger>(context).themeText,
                      style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Reminder defaults',
                    style: FontUtilities.h14(fontColor: Colors.indigoAccent),
                  ),
                ),
                ListTile(
                  onTap: () {
                    provider.showtimePicker(context);
                  },
                  title: Text('Morning',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Text(provider.timeText,
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    provider.showtimePicker1(context);
                  },
                  title: Text('Afternoon',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Text(provider.timeText1,
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    provider.showtimePicker2(context);
                  },
                  title: Text('Evening',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Text(provider.timeText2,
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Sharing',
                    style: FontUtilities.h14(fontColor: Colors.indigoAccent),
                  ),
                ),
                ListTile(
                  onTap: () {
                    provider.changeSwithValue4();
                  },
                  title: Text('Enable sharing',
                      style: FontUtilities.h16(
                        fontColor: VariableUtilities.theme.keeptextColor,
                      )),
                  trailing: Switch(
                    value: provider.isbuttonon4,
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.grey.shade300,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      provider.changeSwithValue4();
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
