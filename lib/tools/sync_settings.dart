// ignore_for_file: avoid_print

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
    systemBasedTheme = prefs.getBool("system_based_theme") ?? false;
    isDark = prefs.getBool("theme") ?? false;
    if (isDark) {
      themeMode = ThemeMode.dark;
      themeIcon = Icons.dark_mode;
    } else {
      themeMode = ThemeMode.light;
      themeIcon = Icons.sunny;
    }
    print(
        "Theme setting from previous session recieved ----> isDark = $isDark");
    print(
        "Theme setting from previous session recieved ----> systemBasedTheme = $systemBasedTheme");
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble();
  }

  void setSessionTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", isDark);
    print(
        "Session theme stored into cache .i.e.isDark = ${prefs.getBool("theme")}");
  }

  void setSystemBasedThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("system_based_theme", systemBasedTheme);
    print(
        "Session system based theme preference stored into cache .i.e.systemBasedTheme = ${prefs.getBool("system_based_theme")}");
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
