// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../tools/theme.dart';

import '../global_values.dart';

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
          onPressed: () {
            Navigator.pop(context);
            if (widget.currentPage["route_name"] == "settings") return;
            Navigator.pushNamed(context, 'settings');
          },
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
          switchThemeMode();
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
        fit: BoxFit.cover,
      ),
    );
  }

  Widget sectionText(
      {required String txt, required String link, double size = 14}) {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (link != '') {
            await launchUrlString(link, mode: LaunchMode.externalApplication);
          } else {
            return;
          }
        },
        child: Text(txt,
            style: TextStyle(
              color: themeTxtColor(),
              fontSize: size,
            )),
      ),
    );
  }

  Widget sectionBuilder({required dynamic section, required String name}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          sectionDivider(),
          sectionText(txt: name, link: "", size: 17),
          for (var sectionItem in section)
            ListTile(
              enabled:
                  sectionItem["labelName"] == widget.currentPage["labelName"]
                      ? false
                      : true,
              tileColor: themeBgColor(),
              iconColor: themeTxtColor(),
              textColor: themeTxtColor(),
              leading: Icon(sectionItem["icon"]),
              title: Text(sectionItem["labelName"]),
              onTap: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, sectionItem["route_name"]);
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width / 1.1;
    if ((MediaQuery.of(context).size.width / 1.1) > 500) {
      drawerWidth = 500;
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        backgroundColor: themeBgColor(),
        elevation: 20,
        width: drawerWidth,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            picture(),
            sectionBuilder(section: pages, name: "Pages"),
            sectionBuilder(section: features, name: "Features"),
            sectionDivider(),
            options(),
            systemBasedTheme ? const SizedBox.shrink() : themeButton(),
            sectionDivider(),
            sectionText(
              txt: "Made by Mudit Garg",
              link: 'https://muditgarg48.github.io',
            ),
          ],
        ),
      ),
    );
  }
}
