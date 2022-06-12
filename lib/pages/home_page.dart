//Packages
// import 'package:candle_in_dark/widgets/drawer.dart';
import 'package:candle_in_dark/widgets/bottom_navbar.dart';
import 'package:candle_in_dark/widgets/theme_data.dart';
import "package:flutter/material.dart";
import 'package:quds_ui_kit/animations/quds_animations.dart';

//Variables
import "../global_values.dart";
import '../widgets/warning_dialogue.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPageIndex = 2;

  void switchTheme(String choice) {
    setState(() {
      if (themeMode == ThemeMode.light) {
        themeMode = ThemeMode.dark;
        themeIcon = Icons.sunny;
        isDark = true;
      } else if (themeMode == ThemeMode.dark) {
        themeMode = ThemeMode.light;
        themeIcon = Icons.dark_mode;
        isDark = false;
      }
    });
    (context as Element).reassemble();
    // displayTheme();
  }

  void displayTheme() {
    print(themeMode);
    print(isDark);
    print(themeIcon);
  }

  void setPageIndex(int index) {
    setState(() => currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // body: pages[currentPageIndex]["class"],
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[...pages.map((page) => page["class"]).toList()],
      ),
      bottomNavigationBar: MyBottomNavbar1(
        pages: pages,
        currentPageIndex: currentPageIndex,
        setPageIndex: setPageIndex,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: invertedThemeTxtColor(),
        onPressed: () {
          var warning = WarningDialogue(
            confirmationMsg: "Toggle light/dark mode ?",
            choice: "theme_change",
            jobDone: Icons.toggle_on,
            action: switchTheme,
          );
          warning.clearBoard(context);
        },
        tooltip: "Choose theme",
        label: Row(
          children: [
            Icon(
              themeIcon,
              color: !isDark ? kToLight.shade900 : kToDark.shade900,
            ),
            const SizedBox(width: 5),
            QudsAnimatedText(
              !isDark ? "DARK" : "LIGHT",
              style: TextStyle(
                color: !isDark ? kToLight.shade900 : kToDark.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
