// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/font_styles.dart';
import '../tools/account_handle.dart';
import '../tools/cache.dart';
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
  Widget options(List<String> whichOptions, MainAxisAlignment axisArrangement) {
    return Row(
      mainAxisAlignment: axisArrangement,
      children: [
        whichOptions.contains("home")
            ? IconButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => false);
                  Navigator.pushNamed(context, 'index');
                },
                icon: Icon(Icons.home, color: themeTxtColor()),
              )
            : const SizedBox.shrink(),
        whichOptions.contains("settings")
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (widget.currentPage["route_name"] == "settings") return;
                  Navigator.pushNamed(context, 'settings');
                },
                icon: Icon(Icons.settings, color: themeTxtColor()),
              )
            : const SizedBox.shrink(),
        whichOptions.contains("close_drawer")
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.clear, color: themeTxtColor()),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget themeButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
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
    var userName = "Anonymous User";
    var userPicURL = "";
    var user = FirebaseAuth.instance.currentUser;
    if (GoogleServices().isUserSignedIn()) {
      userName = user!.displayName!;
      userPicURL = user.photoURL!;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(40)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/imgs/trinity_drawer.jpg",
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: themeBgColor(),
                    child: user == null
                        ? Icon(
                            Icons.people_alt_rounded,
                            color: themeTxtColor(),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: cacheImage(userPicURL),
                          ),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionText({
    required String txt,
    required String link,
    double size = 14,
  }) {
    var title = Text(
      txt,
      style: appFont(
        fontDesign: TextStyle(
          color: themeTxtColor(),
          fontSize: size,
        ),
      ),
    );
    return Center(
      child: link == ''
          ? title
          : TextButton(
              onPressed: () async {
                if (link != '') {
                  await launchUrlString(link,
                      mode: LaunchMode.externalApplication);
                } else {
                  return;
                }
              },
              child: title,
            ),
    );
  }

  Widget sectionBuilder({required dynamic section, required String name}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 30),
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
              title: Text(
                sectionItem["labelName"],
                style: appFont(
                  fontDesign: TextStyle(
                    fontWeight: sectionItem["labelName"] ==
                            widget.currentPage["labelName"]
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
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
    double drawerWidth = (MediaQuery.of(context).size.width / 1.1) > 450
        ? 450
        : MediaQuery.of(context).size.width / 1.1;

    var sectionSpacing =
        SizedBox(height: MediaQuery.of(context).size.height / 30);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Drawer(
          backgroundColor: themeBgColor(),
          elevation: 20,
          width: drawerWidth,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              picture(),
              sectionSpacing,
              options(["home", "close_drawer"], MainAxisAlignment.spaceEvenly),
              GoogleServices().isUserSignedIn()
                  ? sectionBuilder(section: pages, name: "Pages")
                  : Column(children: [sectionDivider(), sectionSpacing]),
              GoogleServices().isUserSignedIn()
                  ? sectionBuilder(section: features, name: "Features")
                  : Center(
                      child: Text(
                        "Sign In to use the app and its features!",
                        style: appFont(
                          fontDesign: TextStyle(color: themeTxtColor()),
                        ),
                      ),
                    ),
              sectionSpacing,
              sectionDivider(),
              options(["settings"], MainAxisAlignment.center),
              sectionSpacing,
              systemBasedTheme ? const SizedBox.shrink() : themeButton(),
              sectionSpacing,
              sectionDivider(),
              sectionText(
                txt: "Made by Mudit Garg",
                link: 'https://muditgarg48.github.io',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
