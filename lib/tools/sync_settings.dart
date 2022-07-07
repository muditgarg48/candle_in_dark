import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global_values.dart';

class SyncSettings extends StatefulWidget {
  const SyncSettings({Key? key}) : super(key: key);

  @override
  State<SyncSettings> createState() => SyncSettingsState();
}

class SyncSettingsState extends State<SyncSettings> {
  
  void getPreviousSessionTheme(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Alternate for prefs.getBool("theme") == null?false
    bool retrievedIsDark = prefs.getBool("theme") ?? false;
    // retrievedIsDark ??= false; => Alternate for if(retrievedIsDark == null) retrievedIsDark = false;
    isDark = retrievedIsDark;
    if (retrievedIsDark) {
      themeMode = ThemeMode.dark;
      themeIcon = Icons.dark_mode;
    } else {
      themeMode = ThemeMode.light;
      themeIcon = Icons.sunny;
    }
    print("Theme setting from previous session recieved ----> isDark = $isDark");
    (context as Element).reassemble();
  }

  void setSessionTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", isDark);
    print(
        "Session theme stored into cache .i.e.isDark = ${prefs.getBool("theme")}");
  }

  void getPreviousSessionSettings(BuildContext context) {
    getPreviousSessionTheme(context);
  }

  void clearSessionDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("");
  }
}
