//Packages
import 'package:flutter/material.dart';

//Pages
import './pages/home_page.dart';

//Variables
import './global_values.dart';

//Widgets

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
      },
    );
  }
}
