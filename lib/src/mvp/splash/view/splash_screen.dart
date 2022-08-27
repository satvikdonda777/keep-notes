import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider_app/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Splash Screen.
class SplashScreen extends StatefulWidget {
  /// Constructor of the Splash Screen.
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    // startTimer();
    initializeSettings();
  }

  /// Start Timer...
  Future startTimer() async {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      timer.cancel();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool checkLog = preferences.getBool('isLoged') ?? false;
      print(checkLog);
      // bool isLogin = VariableUtilities.preferences.getBool('email') ?? false;
      if (checkLog) {
        /// if user is logged in then redirect to the homescreen.
        String homeScreen = RouteUtilities.userScreen;
        await Navigator.pushReplacementNamed(context, homeScreen);
      } else {
        /// if user is not logged in then redirect to the loginscreen.
        String loginScreen1 = RouteUtilities.userScreen;

        /// if user is logged for the first time,
        /// then we are redirecting to the onboarding screen.
        if (_checkFirstTimeUser()) {
          loginScreen1 = RouteUtilities.loginScreen;
        } else {
          await Navigator.pushReplacementNamed(
              context, RouteUtilities.userScreen,
              arguments: {});
        }
        await Navigator.pushReplacementNamed(context, loginScreen1,
            arguments: {});
      }
    });
  }

  /// initialize the settings.
  Future<void> initializeSettings() async {
    /// initialize the theme.
    ThemeManager.initializeTheme(context);

    /// Settings Instance of SharedPreferences.
    VariableUtilities.preferences = await SharedPreferences.getInstance();

    /// initialize the theme.
    ThemeManager.initializeTheme(context);

    await startTimer();
  }

  /// this is the function to check
  /// if the user is opening application for the first time,
  /// then showing onboarding screen
  /// otherwise skip onboarding screen.

  bool _checkFirstTimeUser() {
    return VariableUtilities.preferences
            .getBool(LocalCacheKey.applicationFirstTimeState) ??
        true;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VariableUtilities.screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.brush_outlined,
            size: 150,
            color: Colors.amber,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Keep Notes',
            style: FontUtilities.h50(
              fontColor: VariableUtilities.theme.primaryColor600,
              fontWeight: FWT.extraBold,
            ),
          ),
        ],
      )),
    );
  }
}
