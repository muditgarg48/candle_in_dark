import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/toasts.dart';
import '../widgets/appBar.dart';
import '../widgets/drawer.dart';

import '../tools/fetch_json.dart';
import '../tools/theme.dart';
import '../tools/filter_list.dart';

import '../global_values.dart';

class WorldClock extends StatefulWidget {
  const WorldClock({Key? key}) : super(key: key);

  @override
  WorldClockState createState() => WorldClockState();
}

class WorldClockState extends State<WorldClock> {
  bool isDigital = true;
  DateTime chosenTime = DateTime.now();
  String chosenTimezone = 'Loading ...';
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
    List data =
        await fetchFromJSON_Online('https://worldtimeapi.org/api/timezone');
    if (!mounted) return;
    setState(() {
      availableTimezones = data;
      availableTimezones.sort();
    });
    // printDetails();
  }

  void initCurrentTimezone() async {
    Map data = await fetchFromJSON_Online('https://worldtimeapi.org/api/ip');
    // Response response = await get(Uri.parse('https://worldtimeapi.org/api/ip'));
    // Map data = jsonDecode(response.body);
    setTimeZone(
      timeZone: data["timezone"],
      dateTime: DateTime.parse(data["utc_datetime"]),
      offsetSeconds: data["raw_offset"],
      dst: data["dst_offset"],
    );
    // printDetails();
  }

  void setTimeZone({
    required String timeZone,
    required DateTime dateTime,
    required int offsetSeconds,
    required int dst,
  }) {
    setState(() {
      chosenTimezone = timeZone;
      chosenTime = dateTime;
      chosenTime = chosenTime.add(Duration(seconds: offsetSeconds + dst));
    });
  }

  void resetTimeZone() async {
    initCurrentTimezone();
    toast(
      context: context,
      msg: "Back to $chosenTimezone",
      startI: Icons.location_on,
    );
  }

  void timeCalcByLocation(String location) async {
    Map data = await fetchFromJSON_Online(
        'https://worldtimeapi.org/api/timezone/$location');
    if (!mounted) return;
    setTimeZone(
      timeZone: data["timezone"],
      dateTime: DateTime.parse(data["utc_datetime"]),
      offsetSeconds: data["raw_offset"],
      dst: data["dst_offset"],
    );
    // printDetails();
  }

  Future chooseLocationSheet() {
    var searchController = TextEditingController();
    currentList = availableTimezones;
    return showBarModalBottomSheet(
      // backgroundColor: themeBgColor(),
      context: context,
      enableDrag: true,
      builder: (c) => ListView(
        children: [
          Container(
            color: themeBgColor(),
            child: TextField(
              inputFormatters: [FilteringTextInputFormatter.deny(' ')],
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
                setState(
                    () => currentList = filterList(availableTimezones, input));
                // ignore: invalid_use_of_protected_member
                (c as Element).reassemble();
              },
              showCursor: true,
            ),
          ),
          for (int index = 0; index < currentList.length; index++)
            ListTile(
              title: Text(
                currentList[index],
                style: TextStyle(
                  color: invertedThemeTxtColor(),
                  fontWeight: chosenTimezone == currentList[index]
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              tileColor: themeBgColor(),
              onTap: () {
                // print("User chose ${availableTimezones[index]}");
                timeCalcByLocation(currentList[index]);
                Navigator.pop(context);
                // (context as Element).reassemble();
              },
            ),
        ],
      ),
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

  // void printDetails() {
  //   print("DIGITAL CLOCK: $isDigital");
  //   print("TIME: $chosenTime");
  //   print("TIMEZONE: $chosenTimezone");
  //   print("OFFSET: $offset");
  //   print("====================");
  // }

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
      drawer: MyDrawer(
        currentPage: features[0],
      ),
      body: Container(
        color: themeBgColor(),
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            customSliver(
              appBarTitle: features[0]["appBarTitle"],
              appBarBG: features[0]["appBarBG"],
            ),
          ],
          body: clockFormatSwitcher(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
