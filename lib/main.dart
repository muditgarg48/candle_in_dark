//Packages
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

import './pages/home_page.dart';

import './global_values.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initialiseFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() => print("FireBase Initialised!"));
  }

  @override
  Widget build(BuildContext context) {
    initialiseFirebase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Candle in Dark',
      theme: ThemeData(
        primarySwatch: kToLight,
      ),
      darkTheme: ThemeData(
        primarySwatch: kToDark,
      ),
      themeMode: themeMode,
      initialRoute: 'index',
      routes: {
        'index': (context) => const MyHomePage(),
        for (var page in pages) page['route_name']: page['route'],
        for (var feature in features) feature['route_name']: feature['route'],
        settings["route_name"]: settings['route'],
      },
    );
  }
}
