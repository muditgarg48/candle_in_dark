import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/services.dart';

import '../global_values.dart';

import '../tools/cache_items.dart';
import '../tools/fetch_json.dart';
import '../tools/launch_url.dart';
import '../tools/theme.dart';

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

  // ignore: non_constant_identifier_names
  void getJSON_Local() async {
    var retrievedData = await fetchFromJSON_Local("assets/json/imp_links.json");
    setState(() {
      impLinksJSON = retrievedData;
    });
  }

  Widget singleSection(
    String sectionHead,
    List links,
    List linkNames,
    String imageURL,
  ) {
    return Card(
      elevation: 20,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(40),
        bottomLeft: Radius.circular(40),
      )),
      margin: const EdgeInsets.all(5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          cacheImage(imageURL),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(5),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.1,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                      Text(
                        sectionHead,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: themeTxtColor(),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      for (int i = 0; i < linkNames.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            singleLink(linkNames[i], links[i]),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget printSections() {}
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: themeTxtColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ExpandChild(
            arrowColor: themeTxtColor(),
            expandDirection: Axis.horizontal,
            child: Row(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget differentSections() {
    getJSON_Local();
    return BannerCarousel.fullScreen(
      animation: true,
      activeColor: themeBgColor(),
      disableColor: invertedThemeTxtColor(),
      // width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      initialPage: 0,
      viewportFraction: 0.95,
      indicatorBottom: false,
      customizedBanners: [
        for (int sectionNum = 0; sectionNum < impLinksJSON.length; sectionNum++)
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
        currentPage: pages[4],
      ),
      body: Container(
        // decoration: appBarDecor,
        color: themeBgColor(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const customSliver(
              appBarTitle: "IMPORTANT LINKS",
              appBarBG:
                  "https://cdn.hswstatic.com/gif/web-addresses-english-orig.jpg",
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
