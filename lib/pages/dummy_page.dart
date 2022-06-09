//Packages
import 'package:flutter/material.dart';

//Pages
import '../widgets/appBar.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: appBarDecor,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const customSliver(
              appBarTitle: "DUMMY PAGE",
              appBarBG:
                  "https://miro.medium.com/max/1400/1*WmSNhK1BGctLUuXFVnV8pw.jpeg",
            ),
          ],
          body: const Center(
            child: Text("Hi !"),
          ),
        ),
      ),
    );
  }
}
