//Packages
// import 'package:candle_in_dark/widgets/drawer.dart';
import 'package:candle_in_dark/widgets/toasts.dart';
import "package:flutter/material.dart";
import 'package:quds_ui_kit/animations/quds_animations.dart';

//Variables
import "../global_values.dart";
import '../widgets/confirmation_dialogue.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPageIndex = 0;

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
    displayTheme();
    // toast(context: context, msg: "Theme Toggled", startI: themeIcon);
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
      body: pages[currentPageIndex]["class"],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kToDark.shade300,
        // backgroundColor: isDark ? kToDark.shade800 : kToLight.shade800,
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.shifting,
        elevation: 15,
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(opacity: 1),
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(opacity: 0.3),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: !isDark ? kToDark.shade700 : kToLight.shade700,
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
