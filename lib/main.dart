import 'package:candle_in_dark/tools/account_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tools/sync_settings.dart';
import '../firebase/firebase_access.dart';
import './global_values.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialiseFirebase().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void setDeviceOrientation() => SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    checkFirebaseInstance();
    setDeviceOrientation();
    //sending the current page (home page context) to change it according to the settings received from previous session
    SyncSettingsState().getPreviousSessionSettings(context);
    super.initState();
  }

  @override
  void dispose() {
    if (isAdmin) AdminServices().logoutAdmin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Candle in Dark',
      theme: ThemeData(primarySwatch: kToLight),
      darkTheme: ThemeData(primarySwatch: kToDark),
      themeMode: themeMode,
      initialRoute: 'index',
      routes: appRoutes,
    );
  }
}
