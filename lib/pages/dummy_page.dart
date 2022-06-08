import 'package:candle_in_dark/widgets/appBar.dart';
import 'package:flutter/material.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
    );
  }
}
