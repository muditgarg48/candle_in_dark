import 'package:flutter/material.dart';

import '../tools/theme.dart';

import '../widgets/button.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

import '../global_values.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SnackBar decisionDisplay(String txt) {
    return SnackBar(
      content: Text(txt, style: TextStyle(color: themeTxtColor())),
      backgroundColor: themeBgColor(),
      duration: const Duration(seconds: 1, milliseconds: 50),
    );
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
                "Show your data gathered",
                textAlign: TextAlign.center,
              ),
              action: () {},
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget appRelated() {
    return Container(
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
                    decision =
                        decisionDisplay("System based theme modes implemented");
                  } else {
                    decision =
                        decisionDisplay("App based theme modes implemented");
                  }
                  ScaffoldMessenger.of(context).showSnackBar(decision);
                },
              ),
              value: systemBasedTheme,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton(content: const Text("Clear cache"), action: () {}),
              myButton(content: const Text("Clear your data"), action: () {}),
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
              action: () {},
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
                action: () {}),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: settings,
      ),
      body: Container(
        decoration: appBarDecor,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            customSliver(
              appBarTitle: settings["appBarTitle"],
              appBarBG: settings["appBarBG"],
            ),
          ],
          // body: const Center(child: Text("Hello!")),
          body: Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: themeBgColor(),
            child: ListView(
              children: [
                userDataRelated(),
                const SizedBox(height: 20),
                appRelated(),
                const SizedBox(height: 20),
                Text("v$versionNumber", textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
