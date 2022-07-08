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

  Widget homePage() {
    return Center(
        child: Text(
      "WELCOME",
      style: TextStyle(
        color: themeTxtColor(),
        fontSize: MediaQuery.of(context).size.height / 20,
        fontWeight: FontWeight.bold,
      ),
    ));
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
