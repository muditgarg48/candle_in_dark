//Packages
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
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[1],
      ),
      body: Container(
        // padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: appBarDecor,
        child: NestedScrollView(
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
      ),
    );
  }
}
