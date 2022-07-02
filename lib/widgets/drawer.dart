// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../global_values.dart';
import '../tools/theme.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key, required this.currentPage}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var currentPage;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Widget options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => false);
            Navigator.pushNamed(context, 'index');
          },
          icon: Icon(Icons.home, color: themeTxtColor()),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings, color: themeTxtColor()),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.clear, color: themeTxtColor()),
        ),
      ],
    );
  }

  Widget themeButton() {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: ElevatedButton(
        onPressed: () {
          switchThemeMode("theme_change");
          // setState(() {});
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, widget.currentPage["route_name"]);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              themeIcon,
              color: themeBgColor(),
            ),
            const SizedBox(width: 5),
            QudsAnimatedText(
              !isDark ? "DARK" : "LIGHT",
              style: TextStyle(
                color: themeBgColor(),
              ),
            ),
          ],
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

  Widget picture() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(40)),
      child: Image.asset(
        "assets/imgs/trinity.jpg",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget aboutMe() {
    return Center(
      child: TextButton(
        onPressed: () async {
          const url = 'https://muditgarg48.github.io';
          await launchUrlString(url, mode: LaunchMode.externalApplication);
        },
        child: Text("Made by Mudit Garg",
            style: TextStyle(color: themeTxtColor())),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        backgroundColor: themeBgColor(),
        elevation: 20,
        width: MediaQuery.of(context).size.width / 1.1,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            picture(),
            for (var page in pages)
              ListTile(
                enabled: page["labelName"] == widget.currentPage["labelName"]
                    ? false
                    : true,
                tileColor: themeBgColor(),
                iconColor: themeTxtColor(),
                textColor: themeTxtColor(),
                leading: Icon(page["icon"]),
                title: Text(page["labelName"]),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, page["route_name"]);
                },
              ),
            sectionDivider(),
            options(),
            themeButton(),
            sectionDivider(),
            aboutMe(),
          ],
        ),
      ),
    );
  }
}
