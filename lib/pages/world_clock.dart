import 'dart:async';
import 'dart:convert';
import 'package:candle_in_dark/widgets/theme_data.dart';
import 'package:candle_in_dark/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/appBar.dart';

class WorldClock extends StatefulWidget {
  const WorldClock({Key? key}) : super(key: key);

  @override
  WorldClockState createState() => WorldClockState();
}

class WorldClockState extends State<WorldClock> {
  bool isDigital = true;
  DateTime chosenTime = DateTime.now();
  String chosenTimezone = '';
  List availableTimezones = [];
  String offset = '';
  List currentList = [];

  @override
  void initState() {
    initTimeZones();
    initCurrentTimezone();
    Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (Timer t) {
        timeCalcByLocation(chosenTimezone);
      },
    );
    super.initState();
  }

  void initTimeZones() async {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
    List data = jsonDecode(response.body);
    if (!mounted) return;
    setState(() {
      availableTimezones = data;
      availableTimezones.sort();
    });
    // printDetails();
  }

  void initCurrentTimezone() async {
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/ip'));
    Map data = jsonDecode(response.body);
    setState(() {
      chosenTimezone = data["timezone"];
      chosenTime = DateTime.parse(data["datetime"]);
      offset = data["utc_offset"];
      if (offset[0] == '+') {
        chosenTime.add(Duration(seconds: data["raw_offset"]));
      } else if (offset[0] == '-') {
        chosenTime.subtract(Duration(seconds: data["raw_offset"]));
      }
    });
    // printDetails();
  }

  void resetTimeZone() async {
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/ip'));
    Map data = jsonDecode(response.body);
    setState(() {
      chosenTimezone = data["timezone"];
      chosenTime = DateTime.parse(data["datetime"]);
      offset = data["utc_offset"];
      if (offset[0] == '+') {
        chosenTime.add(Duration(seconds: data["raw_offset"]));
      } else if (offset[0] == '-') {
        chosenTime.subtract(Duration(seconds: data["raw_offset"]));
      }
    });
    toast(
      context: context,
      msg: "Back to $chosenTimezone",
      startI: Icons.location_on,
    );
  }

  List filterList(String searchTerm) {
    return availableTimezones
        .where((element) => element.toLowerCase().contains(searchTerm))
        .toList();
  }

  Future chooseLocationSheet() {
    var searchController = TextEditingController();
    currentList = availableTimezones;
    return showBarModalBottomSheet(
      backgroundColor: themeBgColor(),
      context: context,
      builder: (c) => ListView.builder(
        itemCount: currentList.length + 1,
        itemBuilder: (context, index) => index == 0
            ? Container(
                color: themeBgColor(),
                margin: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: themeTxtColor(),
                  controller: searchController,
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    labelText: "Search",
                    labelStyle: TextStyle(
                      color: themeTxtColor(),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: themeTxtColor(),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: themeTxtColor(),
                      ),
                      onPressed: () {
                        if (searchController.text == '') {
                          Navigator.pop(context);
                        } else {
                          searchController.text = '';
                          currentList = availableTimezones;
                        }
                      },
                    ),
                  ),
                  onChanged: (input) {
                    if (input == '') {
                      setState(() {
                        currentList = availableTimezones;
                      });
                    }
                    setState(() => currentList = filterList(input));
                    (context as Element).reassemble();
                  },
                  showCursor: true,
                ),
              )
            : Card(
                color: themeBgColor(),
                child: ListTile(
                  title: Text(
                    currentList[index - 1],
                    style: TextStyle(
                      color: invertedThemeTxtColor(),
                      fontWeight: chosenTimezone == currentList[index - 1]
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    // print("User chose ${availableTimezones[index]}");
                    timeCalcByLocation(currentList[index - 1]);
                    Navigator.pop(context);
                    // (context as Element).reassemble();
                  },
                ),
              ),
      ),
      enableDrag: true,
    );
  }

  Widget myAnalogClock(BuildContext context) {
    return Center(
      key: ValueKey(chosenTime),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: "Choose Location",
                onPressed: chooseLocationSheet,
                icon: Icon(
                  Icons.location_on,
                  color: themeTxtColor(),
                ),
              ),
              TextButton(
                onPressed: chooseLocationSheet,
                child: Text(
                  "Choose Location",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Current Timezone: $chosenTimezone",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 50,
              color: themeTxtColor(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Text(
            DateFormat('EEE, MMM d').format(chosenTime),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 30,
              color: themeTxtColor(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          AnalogClock(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.0,
                color: themeTxtColor(),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: 2,
                  blurStyle: BlurStyle.outer,
                  color: themeBgColor(),
                ),
              ],
              color: themeBgColor(),
              shape: BoxShape.circle,
            ),
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 3,
            isLive: true,
            hourHandColor: themeTxtColor(),
            minuteHandColor: themeTxtColor(),
            showSecondHand: true,
            numberColor: themeTxtColor(),
            showNumbers: true,
            showDigitalClock: false,
            textScaleFactor: 1.5,
            showTicks: true,
            datetime: chosenTime,
          ),
        ],
      ),
    );
  }

  Widget myDigitalClock(BuildContext context) {
    return Center(
      key: ValueKey(chosenTime),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: chooseLocationSheet,
                icon: Icon(
                  Icons.location_on,
                  color: themeTxtColor(),
                ),
              ),
              TextButton(
                onPressed: chooseLocationSheet,
                child: Text(
                  "Choose Location",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Current Timezone: $chosenTimezone",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 50,
              color: themeTxtColor(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('h:mm').format(chosenTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 15,
                          color: themeTxtColor(),
                        ),
                      ),
                      Text(
                        DateFormat('ss').format(chosenTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 50,
                          color: themeTxtColor(),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat('a').format(chosenTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 32,
                          color: themeTxtColor(),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('EEE, MMM d').format(chosenTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 50,
                      color: themeTxtColor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void timeCalcByLocation(String location) async {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$location'));
    Map data = jsonDecode(response.body);
    if (!mounted) return;
    setState(() {
      chosenTimezone = data["timezone"];
      chosenTime = DateTime.parse(data["datetime"]);
      offset = data["utc_offset"];
      if (offset[0] == '+') {
        chosenTime = chosenTime.add(Duration(seconds: data["raw_offset"]));
      } else if (offset[0] == '-') {
        chosenTime = chosenTime.subtract(Duration(seconds: data["raw_offset"]));
      }
    });
    // printDetails();
  }

  void printDetails() {
    print("DIGITAL CLOCK: $isDigital");
    print("TIME: $chosenTime");
    print("TIMEZONE: $chosenTimezone");
    print("OFFSET: $offset");
    print("====================");
  }

  dynamic clockFormatSwitcher() {
    return ConcentricPageView(
      colors: themeShades(),
      radius: MediaQuery.of(context).size.width,
      itemCount: null, // null = infinity
      physics: const AlwaysScrollableScrollPhysics(),
      duration: const Duration(milliseconds: 900),
      itemBuilder: (int index) {
        index %= 2;
        return Container(
          padding: const EdgeInsets.all(8),
          child: Container(
            child: index % 2 == 0
                ? myAnalogClock(context)
                : myDigitalClock(context),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(themeBgColor()),
      extendBodyBehindAppBar: true,
      // drawer: myDrawer(context),
      body: Container(
        color: themeBgColor(),
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const customSliver(
              appBarTitle: "WORLD CLOCK",
              appBarBG:
                  "https://images.unsplash.com/photo-1502920514313-52581002a659?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1167&q=80",
            ),
          ],
          body: clockFormatSwitcher(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: IconButton(
        onPressed: resetTimeZone,
        tooltip: "Reset Timezone",
        icon: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
