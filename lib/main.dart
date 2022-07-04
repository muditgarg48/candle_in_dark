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
  Widget build(BuildContext context) {
    setDeviceOrientation();
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
