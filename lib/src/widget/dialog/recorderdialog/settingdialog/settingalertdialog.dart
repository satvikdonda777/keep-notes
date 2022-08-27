import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/settings_provider.dart';
import 'package:provider_app/src/mvp/users/provider/theme/themeprovider.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';
import 'package:provider_app/utilities/theme/theme.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  @override
  Widget build(BuildContext context) {
    final themeChnager = Provider.of<ThemeChanger>(
      context,
    );
    return AlertDialog(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(
        'Choose theme',
        style: FontUtilities.h22(
          fontColor: VariableUtilities.theme.keeptextColor,
          fontWeight: FWT.bold,
        ),
      ),
      content: Consumer<ThemeChanger>(builder: (context, provider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                provider.changeTheme(0, context);
                
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedIndex == 0
                              ? Colors.indigoAccent.shade100
                              : VariableUtilities.theme.keeptextColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: provider.selectedIndex == 0
                            ? Colors.indigoAccent.shade100
                            : VariableUtilities.theme.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Light',
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                provider.changeTheme(1, context);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedIndex == 1
                              ? Colors.indigoAccent.shade100
                              : VariableUtilities.theme.keeptextColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: provider.selectedIndex == 1
                            ? Colors.indigoAccent.shade100
                            : VariableUtilities.theme.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Dark',
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                provider.changeTheme(2, context);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.selectedIndex == 2
                              ? Colors.indigoAccent.shade100
                              : VariableUtilities.theme.keeptextColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: provider.selectedIndex == 2
                            ? Colors.indigoAccent.shade100
                            : VariableUtilities.theme.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'System default',
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor),
                  )
                ],
              ),
            ),
          ],
        );
      }),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'))
      ],
    );
  }
}
