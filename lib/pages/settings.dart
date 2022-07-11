import 'package:flutter/material.dart';

import '../tools/sync_settings.dart';
import '../tools/theme.dart';

import '../widgets/button.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

import '../global_values.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SnackBar decisionDisplay(String txt) {
    return SnackBar(
      content: Text(
        txt,
        style: TextStyle(color: themeTxtColor()),
        textAlign: TextAlign.center,
      ),
      backgroundColor: themeBgColor(),
      duration: const Duration(seconds: 1, milliseconds: 50),
    );
  }

  void showComingSoonSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(decisionDisplay("Coming Soon ..."));
  }

  Widget sectionHeading(String heading) {
    return Center(
      child: Text(
        heading,
        style: TextStyle(
          color: themeTxtColor(),
          fontSize: 20,
        ),
      ),
    );
  }

  Widget sectionDivider() {
    return Divider(
      color: themeTxtColor(),
      endIndent: MediaQuery.of(context).size.width / 10,
      indent: MediaQuery.of(context).size.width / 10,
    );
  }

  Widget userDataRelated() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(top: 13),
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: themeCardColor(),
        boxShadow: [
          BoxShadow(
            blurRadius: 100,
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurStyle: BlurStyle.normal,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          sectionHeading("Your Data Related"),
          sectionDivider(),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 6,
              right: MediaQuery.of(context).size.width / 6,
            ),
            child: myButton(
              content: const Text(
                "Show your data accumulated!",
                textAlign: TextAlign.center,
              ),
              action: () => showComingSoonSnackBar(),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget appRelated() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(top: 13),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: themeCardColor(),
        boxShadow: [
          BoxShadow(
            blurRadius: 100,
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurStyle: BlurStyle.normal,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          sectionHeading("App Related"),
          sectionDivider(),
          const SizedBox(height: 10),
          ListTile(
            enabled: false,
            title: Row(
              children: [
                Text("System based Dark/ Light mode: ",
                    style: TextStyle(color: themeTxtColor())),
                const SizedBox(width: 10),
                systemBasedTheme
                    ? Icon(Icons.brightness_auto, color: themeTxtColor())
                    : Icon(Icons.brightness_medium, color: themeTxtColor()),
              ],
            ),
            trailing: Switch(
              activeColor: invertedThemeTxtColor(),
              onChanged: (value) => setState(
                () {
                  systemBasedTheme = value;
                  SnackBar decision;
                  if (value == true) {
                    decision = decisionDisplay(
                        "System based theme modes implementation: Coming soon ...");
                  } else {
                    decision =
                        decisionDisplay("App based theme modes implemented");
                  }
                  ScaffoldMessenger.of(context).showSnackBar(decision);
                  SyncSettingsState().setSystemBasedThemePreference();
                },
              ),
              value: systemBasedTheme,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton(
                  content: const Text("Clear cache"),
                  action: () => showComingSoonSnackBar()),
              myButton(
                  content: const Text("Clear your data"),
                  action: () => showComingSoonSnackBar()),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 6,
              right: MediaQuery.of(context).size.width / 2.5,
            ),
            child: myButton(
              content: const Text(
                "Check for updates",
                textAlign: TextAlign.center,
              ),
              action: () => showComingSoonSnackBar(),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 2.5,
              right: MediaQuery.of(context).size.width / 6,
            ),
            child: myButton(
                content: const Text(
                  "Report a bug",
                  textAlign: TextAlign.center,
                ),
                action: () => showComingSoonSnackBar()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBgColor(),
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: settings,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customSliver(
            appBarTitle: settings["appBarTitle"],
            appBarBG: settings["appBarBG"],
          ),
        ],
        // body: const Center(child: Text("Hello!")),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: themeBgColor(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              userDataRelated(),
              const SizedBox(height: 20),
              appRelated(),
              const SizedBox(height: 20),
              Text(
                "v$versionNumber",
                textAlign: TextAlign.center,
                style: TextStyle(color: themeTxtColor()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
