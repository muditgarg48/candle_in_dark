import 'package:animated_text_kit/animated_text_kit.dart';
import "package:flutter/material.dart";

import '../global_values.dart';
import '../tools/theme.dart';
import '../widgets/drawer.dart';
// import 'dummy_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget title(List<String> txtList, double size) {
    return AnimatedTextKit(
      animatedTexts: [
        for (var txt in txtList)
          TypewriterAnimatedText(
            txt,
            speed: const Duration(milliseconds: 100),
            cursor: " _",
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget homePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title(
            [
              "WELCOME",
              "to",
              "Candle in Dark",
            ],
            MediaQuery.of(context).size.height / 15,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/imgs/trinity_home_page.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          key: scaffoldKey,
          drawer: MyDrawer(currentPage: pages[0]),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: homePage(),
          backgroundColor: kToDark.shade600.withOpacity(0.5),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
              backgroundColor: themeBgColor(),
              elevation: 20,
              label: Text(
                "Lets start",
                style: TextStyle(color: themeTxtColor()),
              )),
        ),
      ],
    );
  }
}
