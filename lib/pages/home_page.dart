import "package:flutter/material.dart";

import 'dummy_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // int currentPageIndex = 0;

  // void displayTheme() {
  //   print(themeMode);
  //   print(isDark);
  //   print(themeIcon);
  // }

  // void setPageIndex(int index) {
  //   setState(() => currentPageIndex = index);
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: DummyPage(),
    );
  }
}
