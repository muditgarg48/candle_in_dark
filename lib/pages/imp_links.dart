import 'package:candle_in_dark/tools/fetch_json.dart';
import 'package:flutter/material.dart';

import '../global_values.dart';
import '../tools/launch_url.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

class ImpLinksPage extends StatefulWidget {
  const ImpLinksPage({Key? key}) : super(key: key);

  @override
  State<ImpLinksPage> createState() => _ImpLinksPageState();
}

class _ImpLinksPageState extends State<ImpLinksPage> {
  List impLinksJSON = [];

  void getJSON() async {
    var retrievedData = await fetchFromJSON_Local("assets/json/imp_links.json");
    setState(() {
      impLinksJSON = retrievedData;
    });
  }

  Widget printThings() {
    getJSON();
    return ListView(
      children: [
        for (var section in impLinksJSON)
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(section["photo_link"],
                      fit: BoxFit.cover, height: 200, width: 200),
                  const SizedBox(height: 40),
                  Text(section["name"]),
                  const SizedBox(height: 40),
                  for (int i = 0; i < section["link_names"].length; i++)
                    TextButton(
                      onPressed: () => launchURL(section["links"][i]),
                      child: Text(section["link_names"][i]),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[4],
      ),
      body: Container(
        // padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: appBarDecor,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const customSliver(
              appBarTitle: "IMPORTANT LINKS",
              appBarBG:
                  "https://cdn.hswstatic.com/gif/web-addresses-english-orig.jpg",
            ),
          ],
          body: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: printThings(),
          ),
        ),
      ),
    );
  }
}
