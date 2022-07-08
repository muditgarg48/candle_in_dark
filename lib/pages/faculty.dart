import 'package:flutter/material.dart';

import '../global_values.dart';

import '../widgets/appBar.dart';
import '../widgets/drawer.dart';
import '../widgets/loading.dart';

import '../tools/theme.dart';

import '../firebase/firebase_access.dart';

class TheFacultyPage extends StatefulWidget {
  const TheFacultyPage({Key? key}) : super(key: key);

  @override
  State<TheFacultyPage> createState() => TheFacultyPageState();
}

class TheFacultyPageState extends State<TheFacultyPage> {
  List data = [];

  @override
  void initState() {
    getFacultyJSON();
    super.initState();
  }

  void getFacultyJSON() async {
    //for offline access
    // var fileData = await fetchFromJSON_Local("assets/json/faculty.json");
    //for firebase access
    var fileData = await getJSON(linkFromRoot: "json/faculty.json");
    setState(() => data = fileData);
  }

  Widget singleFacultyMember(var faculty) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(30),
      elevation: 20,
      surfaceTintColor: themeBgColor(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.people),
            ),
            const SizedBox(height: 10),
            Text(
              faculty["name"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(faculty["contact_number"]),
            const SizedBox(height: 10),
            Text(faculty["role"]),
          ],
        ),
      ),
    );
  }

  Widget colleges() {
    return ListView(
      children: [
        for (var college in data)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  college["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: themeTxtColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  children: [
                    for (var faculty in college["faculty"])
                      singleFacultyMember(faculty),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget page() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: colleges(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBgColor(),
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: pages[3],
      ),
      body: Container(
        decoration: appBarDecor,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            customSliver(
              appBarTitle: pages[3]["appBarTitle"],
              appBarBG: pages[3]["appBarBG"],
            ),
          ],
          body: data.isEmpty
              ? const LoadingPage(
                  display: "Please wait while we fetch your data ... ",
                )
              : page(),
        ),
      ),
    );
  }
}
