//Packages
import 'package:flutter/material.dart';

import '../global_values.dart';

//Pages
import '../widgets/appBar.dart';
// import '../widgets/drawer.dart';
import '../widgets/drawer.dart';
import '../widgets/loading.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[0],
      ),
      body: Container(
        // padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: appBarDecor,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const customSliver(
              appBarTitle: "ABOUT",
              appBarBG:
                  "https://images.unsplash.com/photo-1565246075196-94d3995a0b37?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80",
            ),
          ],
          body: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: const LoadingPage(),
          ),
        ),
      ),
    );
  }
}
