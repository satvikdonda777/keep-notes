import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/loginscreen/loginpage.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelprovider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/reminderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/mvp/users/view/drawerpage/labelpage/labelpage.dart';
import 'package:provider_app/src/widget/customrow/drawerlabelrow.dart';
import 'package:provider_app/src/widget/customsnackbar/customsnackbar.dart';

import 'package:provider_app/src/widget/widget.dart';
import 'package:provider_app/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget CustomDrawer(BuildContext context) {
  Future<void> signOutFromGoogle() async {
    await googleSignIn.signOut();
    await auth.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('isLoged');
  }

  return Drawer(
    backgroundColor: VariableUtilities.theme.backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: VariableUtilities.theme is DarkTheme
                    ? Text('Google',
                        style: FontUtilities.h22(
                            fontColor: VariableUtilities.theme.keeptextColor,
                            fontWeight: FWT.medium))
                    : Row(
                        children: [
                          Text(
                            'G',
                            style: FontUtilities.h22(
                                fontWeight: FWT.medium,
                                fontColor: Colors.indigoAccent),
                          ),
                          Text(
                            'o',
                            style: FontUtilities.h22(
                                fontWeight: FWT.medium,
                                fontColor: Colors.redAccent),
                          ),
                          Text(
                            'o',
                            style: FontUtilities.h22(
                                fontWeight: FWT.medium,
                                fontColor: Colors.orangeAccent),
                          ),
                          Text(
                            'g',
                            style: FontUtilities.h22(
                                fontWeight: FWT.medium,
                                fontColor: Colors.indigoAccent),
                          ),
                          Text(
                            'l',
                            style: FontUtilities.h22(
                                fontWeight: FWT.medium,
                                fontColor: Colors.greenAccent),
                          ),
                          Text(
                            'e',
                            style: FontUtilities.h22(
                                fontWeight: FWT.medium,
                                fontColor: Colors.redAccent),
                          ),
                        ],
                      )),
            const SizedBox(
              width: 8,
            ),
            Text('keep',
                style: FontUtilities.h20(
                    fontColor: VariableUtilities.theme.keeptextColor,
                    fontWeight: FWT.medium)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: draweritemList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Provider.of<UserProvider>(context, listen: false)
                    .checkSelecton(index);
                if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    0) {
                  Navigator.pop(context);
                  Provider.of<UserProvider>(context, listen: false)
                      .isFromindex2 = false;
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteUtilities.userScreen, (route) => false);
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    1) {
                  Navigator.pop(context);

                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteUtilities.reminderScreen, (route) => false);
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    2) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RouteUtilities.labelscreen);
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    3) {
                  Navigator.pop(context);
                  Provider.of<CategoryProvider>(context, listen: false)
                      .undoArchiveBorder();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteUtilities.archiveScreen, (route) => false);
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    4) {
                  Navigator.pop(context);
                  Provider.of<CategoryProvider>(context, listen: false)
                      .undoDeletedBorder();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteUtilities.deleteScreen, (route) => false);
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    5) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RouteUtilities.settingScreen);
                } else if (Provider.of<UserProvider>(context, listen: false)
                        .selectedIndex ==
                    6) {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteUtilities.loginScreen, (route) => false);
                  signOutFromGoogle();

                  ScaffoldMessenger.of(context).showSnackBar(MyCustomSnackbar(
                      'Logout successfull',
                      const TextButton(onPressed: null, child: Text(''))));
                  Provider.of<UserProvider>(context, listen: false)
                      .selectedIndex = 0;
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      draweritemList[index]['content'] == null
                          ? Container()
                          : Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: Provider.of<LabelProvider>(context)
                                          .labelRow
                                          .isEmpty
                                      ? 0
                                      : 10,
                                ),
                                Provider.of<LabelProvider>(context)
                                        .labelRow
                                        .isEmpty
                                    ? Container()
                                    : Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey,
                                      ),
                                Provider.of<LabelProvider>(context)
                                        .labelRow
                                        .isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              'Labels',
                                              style: FontUtilities.h14(
                                                  fontColor: VariableUtilities
                                                      .theme.keeptextColor),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    RouteUtilities.labelscreen);
                                              },
                                              child: Text(
                                                'Edit',
                                                style: FontUtilities.h14(
                                                    fontColor: VariableUtilities
                                                        .theme.keeptextColor),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Consumer<LabelProvider>(
                                      builder: (context, provider, child) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: provider.labelRow.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .horizontal(
                                                              right: Radius
                                                                  .circular(
                                                                      30)),
                                                      color: Provider.of<
                                                                          UserProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .selectedIndex1 ==
                                                              index
                                                          ? VariableUtilities
                                                              .theme
                                                              .drawerContainerColor
                                                          : VariableUtilities
                                                              .theme
                                                              .transparent),
                                                  child: DrawerLabelRow(
                                                    data: provider
                                                        .labelRow[index],
                                                    index: index,
                                                    onrowClick: () {
                                                      Provider.of<UserProvider>(
                                                              context,
                                                              listen: false)
                                                          .checkSelecton1(
                                                              index);
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                        return LabelPageScreen(
                                                            index: index);
                                                      }), (route) => false);
                                                    },
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(30)),
                            color: Provider.of<UserProvider>(context,
                                            listen: false)
                                        .selectedIndex ==
                                    index
                                ? VariableUtilities.theme.drawerContainerColor
                                : VariableUtilities.theme.transparent),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              draweritemList[index]['icon'],
                              color: Provider.of<UserProvider>(context)
                                          .selectedIndex ==
                                      index
                                  ? VariableUtilities.theme.selectedColor
                                  : VariableUtilities
                                      .theme.unselectedOptionColor,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              draweritemList[index]['title'],
                              style: FontUtilities.h16(
                                fontColor: Provider.of<UserProvider>(context)
                                            .selectedIndex ==
                                        index
                                    ? VariableUtilities.theme.selectedColor
                                    : VariableUtilities
                                        .theme.unselectedOptionColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      draweritemList[index]['content'] == null
                          ? Container()
                          : Provider.of<LabelProvider>(context).labelRow.isEmpty
                              ? Container()
                              : Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey,
                                ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
