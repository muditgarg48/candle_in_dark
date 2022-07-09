// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:banner_carousel/banner_carousel.dart';

import '../firebase/firebase_access.dart';

import '../global_values.dart';

import '../tools/cache.dart';
import '../tools/launch_url.dart';
import '../tools/theme.dart';

import '../widgets/loading.dart';
import '../widgets/toasts.dart';
import '../widgets/appBar.dart';
import '../widgets/button.dart';
import '../widgets/drawer.dart';

class ImpLinksPage extends StatefulWidget {
  const ImpLinksPage({Key? key}) : super(key: key);

  @override
  State<ImpLinksPage> createState() => _ImpLinksPageState();
}

class _ImpLinksPageState extends State<ImpLinksPage> {
  List impLinksJSON = [];

  String singleSectionLinks = '';

  // void getJSON_Local() async {
  //   var retrievedData = await fetchFromJSON_Local("assets/json/imp_links.json");
  //   setState(() => impLinksJSON = retrievedData);
  // }

  void setJSON_FireBase() async {
    var temp = await getJSON_FromFirebase(linkFromRoot: "json/imp_links.json");
    setState(() => impLinksJSON = temp);
  }

  void constructIntoTxt(String sectionHead, List links, List linkNames) {
    String data = '';
    data += sectionHead;
    data += "\n======================================";
    for (int i = 0; i < linkNames.length; i++) {
      data += "\n${i + 1} => ${linkNames[i]}: ${links[i]}";
    }
    setState(() => singleSectionLinks = data);
    Clipboard.setData(ClipboardData(text: singleSectionLinks));
    toast(
      context: context,
      msg: "Section data copied!",
      startI: Icons.copy,
    );
  }

  Widget copySectionData(String sectionHead, List links, List linkNames) {
    return myButton(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.assignment),
          SizedBox(width: 5),
          Text('Copy all Links'),
        ],
      ),
      // action: () => constructIntoTxt(sectionHead, links, linkNames),
      action: () => toast(
        context: context,
        msg: "Coming Soon!",
        startI: Icons.timer,
      ),
    );
  }

  Widget singleOption({
    required String url,
    required VoidCallback action,
    required String actionName,
    required IconData actionIcon,
  }) {
    return myButton(
      action: action,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(actionIcon),
          const SizedBox(width: 5),
          Text(actionName),
        ],
      ),
    );
  }

  Widget singleLink(String name, String url) {
    var options = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        singleOption(
          url: url,
          action: () => launchURL(url),
          actionName: "Launch URL",
          actionIcon: Icons.launch,
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 50),
        singleOption(
          url: url,
          action: () {
            Clipboard.setData(ClipboardData(text: url));
            toast(
              context: context,
              msg: "Link Copied",
              startI: Icons.copy,
            );
          },
          actionName: "Copy Link",
          actionIcon: Icons.copy,
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 50),
      ],
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 15,
            child: ListTile(
              iconColor: themeTxtColor(),
              enabled: url == '' ? false : true,
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.link),
              textColor: themeTxtColor(),
              trailing: url != ''
                  ? ExpandChild(
                      arrowColor: themeTxtColor(),
                      expandDirection: Axis.horizontal,
                      child: options,
                    )
                  : IconButton(
                      color: themeTxtColor(),
                      onPressed: () => toast(
                          context: context,
                          msg: "URL Missing!",
                          startI: Icons.warning),
                      icon: const Icon(Icons.warning_sharp),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget singleSection(
    String sectionHead,
    List links,
    List linkNames,
    String imageURL,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        isDark
            ? cacheImage(
                "https://images.unsplash.com/photo-1578509341524-be72cae3705d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
            : cacheImage(imageURL),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.1,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(3),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 100,
                    color: themeBgColor().withOpacity(0.3),
                    spreadRadius: 5,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Text(
                    sectionHead,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeTxtColor(),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Divider(
                    color: themeTxtColor(),
                    endIndent: MediaQuery.of(context).size.width / 15,
                    indent: MediaQuery.of(context).size.width / 15,
                  ),
                  for (int i = 0; i < linkNames.length; i++)
                    singleLink(linkNames[i], links[i]),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: MediaQuery.of(context).size.width / 4,
                      right: MediaQuery.of(context).size.width / 4,
                      bottom: 20,
                    ),
                    child: copySectionData(sectionHead, links, linkNames),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget differentSections() {
    setJSON_FireBase();
    return impLinksJSON.isEmpty
        ? const LoadingPage(
            display: "Please wait while we fetch your data ... ")
        : BannerCarousel.fullScreen(
            animation: true,
            activeColor: themeBgColor(),
            disableColor: invertedThemeTxtColor(),
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            initialPage: 0,
            indicatorBottom: false,
            customizedBanners: [
              for (int sectionNum = 0;
                  sectionNum < impLinksJSON.length;
                  sectionNum++)
                singleSection(
                  impLinksJSON[sectionNum]["name"],
                  impLinksJSON[sectionNum]["links"],
                  impLinksJSON[sectionNum]["link_names"],
                  impLinksJSON[sectionNum]["photo_link"],
                ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[2],
      ),
      body: Container(
        // decoration: appBarDecor,
        color: themeBgColor(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            customSliver(
              appBarTitle: pages[2]["appBarTitle"],
              appBarBG: pages[2]["appBarBG"],
            ),
          ],
          body: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: differentSections(),
          ),
        ),
      ),
    );
  }
}