//Packages
// import 'package:candle_in_dark/widgets/drawer.dart';
import 'package:candle_in_dark/deprecated/deprecated%20widgets/bottom_navbar_deprecated.dart';
import 'package:candle_in_dark/widgets/theme_data.dart';
import "package:flutter/material.dart";
import 'package:quds_ui_kit/animations/quds_animations.dart';

//Variables
import "../global_values.dart";
import '../widgets/warning_dialogue.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = pages.length ~/ 2;

  // void switchTheme(String choice) {
  //   setState(() {
  //     if (themeMode == ThemeMode.light) {
  //       themeMode = ThemeMode.dark;
  //       themeIcon = Icons.sunny;
  //       isDark = true;
  //     } else if (themeMode == ThemeMode.dark) {
  //       themeMode = ThemeMode.light;
  //       themeIcon = Icons.dark_mode;
  //       isDark = false;
  //     }
  //   });
  //   (context as Element).reassemble();
  //   // displayTheme();
  // }

  // FloatingActionButton themeButton() {
  //   return FloatingActionButton.extended(
  //     backgroundColor: invertedThemeTxtColor(),
  //     onPressed: () {
  //       var warning = WarningDialogue(
  //         confirmationMsg: "Toggle light/dark mode ?",
  //         choice: "theme_change",
  //         jobDone: Icons.toggle_on,
  //         action: switchTheme,
  //       );
  //       warning.dialogueBox(context);
  //     },
  //     tooltip: "Choose theme",
  //     label: Row(
  //       children: [
  //         Icon(
  //           themeIcon,
  //           color: themeBgColor(),
  //         ),
  //         const SizedBox(width: 5),
  //         QudsAnimatedText(
  //           !isDark ? "DARK" : "LIGHT",
  //           style: TextStyle(
  //             color: themeBgColor(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void displayTheme() {
  //   print(themeMode);
  //   print(isDark);
  //   print(themeIcon);
  // }

  void setPageIndex(int index) {
    setState(() => currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // body: pages[currentPageIndex]["class"],
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[...pages.map((page) => page["class"]).toList()],
      ),
      // bottomNavigationBar: MyBottomNavbar1(
      //   pages: pages,
      //   currentPageIndex: currentPageIndex,
      //   setPageIndex: setPageIndex,
      // ),
      // floatingActionButton: themeButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
