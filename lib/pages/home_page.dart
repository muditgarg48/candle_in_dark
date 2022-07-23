import "package:flutter/material.dart";
import 'package:animated_text_kit/animated_text_kit.dart';

import '../firebase/firebase_storage_access.dart';
import '../tools/account_handle.dart';
import '../tools/theme.dart';
import '../widgets/font_styles.dart';
import '../widgets/drawer.dart';
import '../global_values.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkFirebaseInstance();
    super.initState();
  }

  Widget title(List<String> txtList, double size) {
    return AnimatedTextKit(
      animatedTexts: [
        for (var txt in txtList)
          TypewriterAnimatedText(
            txt,
            textAlign: TextAlign.center,
            speed: const Duration(milliseconds: 100),
            cursor: "|",
            textStyle: mainHeadingFont(
              fontDesign: TextStyle(
                color: Colors.white,
                fontSize: size,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  TextSpan constructGoogleText(int pos, String ch) {
    var txtColor = Colors.white;
    if (pos % 8 == 0 || pos % 8 == 1) {
      txtColor = const Color(0xff4285F4);
    } else if (pos % 8 == 2 || pos % 8 == 3) {
      txtColor = const Color(0xffDB4437);
    } else if (pos % 8 == 4 || pos % 8 == 5) {
      txtColor = const Color(0xffF4B400);
    } else {
      txtColor = const Color(0xff0F9D58);
    }
    return TextSpan(
      text: ch,
      style: appFont(
        fontDesign: TextStyle(
          color: txtColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget signInbuttons(
    String txt,
    VoidCallback action,
    IconData icon,
    String company,
  ) {
    return MediaQuery.of(context).size.width > 400
        ? FloatingActionButton.extended(
            onPressed: action,
            backgroundColor: themeBgColor(),
            elevation: 20,
            label: company == "Google"
                ? RichText(
                    text: TextSpan(
                    children: [
                      for (var i = 0; i < txt.length; i++)
                        constructGoogleText(i, txt[i])
                    ],
                  ))
                : Text(
                    txt,
                    style: appFont(
                      fontDesign: TextStyle(
                        color: themeTxtColor(),
                      ),
                    ),
                  ),
          )
        : FloatingActionButton(
            onPressed: action,
            tooltip: txt,
            backgroundColor: themeBgColor(),
            child: Icon(icon, color: themeTxtColor()),
          );
  }

  Widget buttons(String txt, VoidCallback action, IconData icon) {
    return MediaQuery.of(context).size.width > 400
        ? FloatingActionButton.extended(
            onPressed: action,
            backgroundColor: themeBgColor(),
            elevation: 20,
            icon: Icon(icon, color: themeTxtColor()),
            label: Text(
              txt,
              style: appFont(
                fontDesign: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeTxtColor(),
                ),
              ),
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
              GoogleServices().isGoogleSignedIn()
                  ? signInbuttons(
                      "Sign Out",
                      () {
                        setState(() => isAdmin = false);
                        GoogleServices().googleSignOut(context);
                      },
                      Icons.login,
                      "Google",
                    )
                  : signInbuttons(
                      "Sign In to Google",
                      () {
                        AdminServices().checkAdmin();
                        GoogleServices().signInWithGoogle(context);
                      },
                      Icons.login,
                      "Google",
                    ),
              const SizedBox(height: 30),
              buttons(
                "Lets start",
                () => scaffoldKey.currentState?.openDrawer(),
                Icons.play_arrow_rounded,
              )
            ],
          ),
        ),
      ],
    );
  }
}
