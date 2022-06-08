//Packages
import 'package:flutter/material.dart';

//Pages
import './pages/home_page.dart';

//Widgets

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Candle in Dark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'index',
      routes: {
        'index': (context) => const MyHomePage(),
      },
    );
  }
}
