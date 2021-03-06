import 'package:flutter/material.dart';

import '../widgets/appBar.dart';
import '../widgets/drawer.dart';
import '../widgets/loading.dart';

import '../tools/theme.dart';

import '../global_values.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBgColor(),
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[0],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customSliver(
            appBarTitle: pages[0]["appBarTitle"],
            appBarBG: pages[0]["appBarBG"],
          ),
        ],
        body: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: const LoadingPage(display: "Coming Soon ..."),
        ),
      ),
    );
  }
}
