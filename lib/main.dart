import 'package:candle_in_dark/firebase/firebase_access.dart';
import 'package:candle_in_dark/tools/sync_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './global_values.dart';

void main() => runApp(const MyApp());

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
    setDeviceOrientation();
    //sending the current page (home page context) to change it according to the settings recieved from previous session
    SyncSettingsState().getPreviousSessionSettings(context);
    initialiseFirebase();
    super.initState();
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
