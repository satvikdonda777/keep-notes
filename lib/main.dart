import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/model/categorymodel/categorymodel.dart';
import 'package:provider_app/src/mvp/users/notification/user_notification.dart';
import 'package:provider_app/src/mvp/users/provider/theme/themeprovider.dart';
import 'package:provider_app/utilities/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Firebase.initializeApp();
  await NotificationService.init();
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox('key');
  runApp(const KeepNotesApp());
  // return runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const KeepNotesApp(),
  // ));
}

///  Main application class from where the application will begin running.
class KeepNotesApp extends StatelessWidget {
  /// Constructor of the main class.
  const KeepNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VariableUtilities.theme = DarkTheme();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Core.hideKeyBoard();
    return MultiProvider(
      providers: ProviderBind.providers,
      builder: (BuildContext context, Widget? child) {
        return Consumer<ThemeChanger>(builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteUtilities.root,
            onGenerateRoute: RouteUtilities.onGenerateRoute,
            darkTheme: ThemeData(brightness: Brightness.dark),
            theme: ThemeData(
              /// this is the default font used for the application.
              brightness: Brightness.light,
              fontFamily: 'lato',
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: VariableUtilities.theme.primaryColor500,
                selectionColor: VariableUtilities.theme.primaryColor500,
                selectionHandleColor: VariableUtilities.theme.primaryColor500,
              ),
            ),
          );
        });
      },
    );
  }
}
