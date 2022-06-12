//Packages
import 'package:flutter/material.dart';

//Pages
import '../widgets/appBar.dart';
// import '../widgets/drawer.dart';
import '../widgets/loading.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // drawer: myDrawer(context),
      body: Container(
        // padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: appBarDecor,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const customSliver(
              appBarTitle: "DUMMY PAGE",
              appBarBG:
                  "https://miro.medium.com/max/1400/1*WmSNhK1BGctLUuXFVnV8pw.jpeg",
            ),
          ],
          body: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: const LoadingPage(),
          ),
          // body: const Center(
          //   child: Text("Hi !"),
          // ),
        ),
      ),
    );
  }
}
