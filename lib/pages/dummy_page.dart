//Packages
import 'package:candle_in_dark/tools/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/appBar.dart';
import '../widgets/drawer.dart';
import '../widgets/loading.dart';

import '../global_values.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBgColor(),
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[1],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customSliver(
            appBarTitle: pages[1]["appBarTitle"],
            appBarBG: pages[1]["appBarBG"],
          ),
        ],
        body: const SizedBox.shrink(
          child: LoadingPage(display: "Coming Soon ..."),
        ),
      ),
    );
  }
}
