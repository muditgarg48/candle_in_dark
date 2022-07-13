import "package:flutter/material.dart";
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            cursor: "|",
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget buttons(String txt, VoidCallback action, IconData icon) {
    return MediaQuery.of(context).size.width > 700
        ? FloatingActionButton.extended(
            onPressed: action,
            backgroundColor: themeBgColor(),
            elevation: 20,
            icon: Icon(icon, color: themeTxtColor()),
            label: Text(
              txt,
              style: TextStyle(color: themeTxtColor()),
            ),
          )
        : FloatingActionButton(
            onPressed: action,
            tooltip: txt,
            backgroundColor: themeBgColor(),
            child: Icon(icon, color: themeTxtColor()),
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
            MediaQuery.of(context).size.height / 17,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
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
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buttons(
                "Sign In to Google",
                () {},
                FontAwesomeIcons.google,
              ),
              const SizedBox(height: 30),
              buttons(
                "Lets start",
                () => scaffoldKey.currentState?.openDrawer(),
                Icons.play_arrow_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
