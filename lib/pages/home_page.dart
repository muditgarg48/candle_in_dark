//Packages
import 'package:candle_in_dark/widgets/drawer.dart';
import 'package:candle_in_dark/widgets/toasts.dart';
import "package:flutter/material.dart";

//Variables
import "../global_values.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPageIndex = 0;

  void switchTheme() {
    setState(() {
      if (themeMode == ThemeMode.light) {
        themeMode = ThemeMode.dark;
        themeIcon = Icons.dark_mode;
        isDark = true;
      } else if (themeMode == ThemeMode.dark) {
        themeMode = ThemeMode.light;
        themeIcon = Icons.sunny;
        isDark = false;
      }
    });
    displayTheme();
    toast(context: context, msg: "Theme Toggled", startI: themeIcon);
  }

  void displayTheme() {
    print(themeMode);
  }

  void setPageIndex(int index) {
    setState(() => currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: myDrawer(),
      body: pages[currentPageIndex]["class"],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0x44aaaaff),
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.shifting,
        elevation: 15,
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(opacity: 1),
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(opacity: 0.2),
        onTap: setPageIndex,
        items: [
          for (var page in pages)
            BottomNavigationBarItem(
              tooltip: page["labelName"],
              backgroundColor: Theme.of(context).backgroundColor,
              icon: page["icon"],
              label: page["labelName"],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => switchTheme(),
        tooltip: "Choose theme",
        child: Icon(themeIcon),
      ),
    );
  }
}
