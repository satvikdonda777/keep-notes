import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelpageprovider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelprovider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/reminderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/settings_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/iconprovider/cusromicon_provider.dart';
import 'package:provider_app/src/mvp/users/provider/recorderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/theme/themeprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';

/// This class manage all the provider and return list of provider.
class ProviderBind {
  /// This is the list of providers to manage and attache with application.
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider<AddScreenProvider>(
      create: (_) => AddScreenProvider(),
    ),
    ChangeNotifierProvider<BrushProvider>(
      create: (_) => BrushProvider(),
    ),
    ChangeNotifierProvider<RecorderProvider>(
      create: (_) => RecorderProvider(),
    ),
    ChangeNotifierProvider<ReminderProvider>(
      create: (_) => ReminderProvider(),
    ),
    ChangeNotifierProvider<LabelProvider>(
      create: (_) => LabelProvider(),
    ),
    ChangeNotifierProvider<LabelPageProvider>(
      create: (_) => LabelPageProvider(),
    ),
    ChangeNotifierProvider<CustomIconProvider>(
      create: (_) => CustomIconProvider(),
    ),
    ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider(),
    ),
    ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
    ),
    ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
    ),
    ChangeNotifierProvider<CategoryProvider>(
      create: (_) => CategoryProvider(),
    ),
  ];
}
