// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/loginscreen/loginpage.dart';
import 'package:provider_app/src/mvp/splash/view/splash_screen.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/view/brushscreen.dart';
import 'package:provider_app/src/mvp/users/view/checknotes.dart';
import 'package:provider_app/src/mvp/users/view/drawerpage/archivepage.dart';
import 'package:provider_app/src/mvp/users/view/drawerpage/deletedpage.dart';
import 'package:provider_app/src/mvp/users/view/drawerpage/label.dart';
import 'package:provider_app/src/mvp/users/view/drawerpage/reminderpage.dart';
import 'package:provider_app/src/mvp/users/view/drawerpage/settingpage.dart';
import 'package:provider_app/src/mvp/users/view/searchscreen.dart';
import 'package:provider_app/src/mvp/users/view/user_screen.dart';

/// Manage all the routes used in the application.
class RouteUtilities {
  /// first screen to open in the application.
  static const String root = '/';

  /// splash screen.
  static const String splashScreen = '/splashScreen';

  //loginScreen
  static const String loginScreen = '/loginScreen';

  /// user screen.
  static const String userScreen = '/userScreen';

  ///search screen
  static const String searchScreen = '/searchScreen';

  ///addnewitem Screen
  static const String addnotesScreen = '/addnotesScreen';

  ///brush Screen
  static const String brushScreen = '/brushScreen';

  //reminderscreen
  static const String reminderScreen = '/reminderScreen';

  //create new labe screen
  static const String labelscreen = '/labelscreen';

  //archive screen
  static const String archiveScreen = '/archiveScreen';

  //delete Screen
  static const String deleteScreen = '/deleteScreen';

  //Setting screen
  static const String settingScreen = '/settingScreen';

  //labelpage
  static const String imagescreen = '/imagescreen';
  static const String blankScreen = '/blankScreen';

  /// we are using named route to navigate to another screen,
  /// and while redirecting to the next screen we are using this function
  /// to pass arguements and other routing things..
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? RouteUtilities.root;

    /// this is the instance of arguements to pass data in other screens.
    dynamic arguements = settings.arguments;
    switch (routeName) {
      case RouteUtilities.root:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RouteUtilities.splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RouteUtilities.userScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => UserScreen(),
        );
      case RouteUtilities.searchScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SearchScreen());

      case RouteUtilities.addnotesScreen:
   
        return MaterialPageRoute(
            builder: (BuildContext context) => AddNotesScreen(
                categoryModel: Provider.of<CategoryProvider>(context, listen: false)
                            .categorySelectedIndex ==
                        null
                    ? null
                    : Provider.of<CategoryProvider>(context, listen: false).allCategory[
                        Provider.of<CategoryProvider>(context, listen: false)
                            .categorySelectedIndex!],
                isEditMode:
                    Provider.of<CategoryProvider>(context, listen: false)
                                .categorySelectedIndex ==
                            null
                        ? false
                        : true,
                index: Provider.of<CategoryProvider>(context, listen: false)
                    .categorySelectedIndex));

      case RouteUtilities.brushScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => BrushScreen());
      case RouteUtilities.reminderScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ReminderPage());
      case RouteUtilities.labelscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LabelPage());
      case RouteUtilities.archiveScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ArchivePage());
      case RouteUtilities.deleteScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DeletedPage());
      case RouteUtilities.settingScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SettingPage());
      case RouteUtilities.loginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
    }
  }
}
