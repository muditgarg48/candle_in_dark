//Packages
// ignore_for_file: invalid_use_of_protected_member

import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:candle_in_dark/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../tools/fetch_json.dart';
import '../tools/theme.dart';
import '../widgets/drawer.dart';
import '../firebase/firebase_access.dart';

import '../global_values.dart';

class CalmPage extends StatefulWidget {
  const CalmPage({Key? key}) : super(key: key);

  @override
  State<CalmPage> createState() => CalmPageState();
}

class CalmPageState extends State<CalmPage> {
  List audioNames = [];
  List audios = [];

  @override
  void initState() {
    getAudioJSON();
    super.initState();
  }

  @override
  void dispose() {
    stopAll();
    disposeAllPlayers();
    super.dispose();
  }

  void stopAll() {
    for (var audio in audios) {
      audio["controller"].stop();
      (context as Element).reassemble();
    }
  }

  void disposeAllPlayers() {
    for (var audio in audios) {
      audio["controller"].dispose();
    }
  }

  void getAudioJSON() async {
    List fileData = await fetchFromJSON_Local("assets/json/calm_audios.json");
    // ignore: avoid_print
    print("MY DATA: $fileData");
    setState(() => audioNames = fileData);
    mapAudios();
    toast(
      context: context,
      msg:
          "Please wait till all tunes have been fetched, there are ${audioNames.length} of them",
      startI: Icons.audiotrack_rounded,
    );
  }

  Future<Uint8List> getIcon(String name) async {
    Uint8List imgBytes = (await getFromFirebase_File(linkFromRoot: name))!;
    return imgBytes;
  }

  void mapAudios() async {
    for (var audioName in audioNames) {
      var pic = await getIcon("audios/icons/$audioName.png");
      var audioLink = await getFromFirebase_FileURL(
          linkFromRoot: "audios/ogg/$audioName.ogg");
      var player = AudioPlayer(playerId: audioName);
      await player.setSourceUrl(audioLink);
      player.setPlayerMode(PlayerMode.lowLatency);
      var temp = {
        "name": audioName,
        "pic": pic,
        "volume": 20,
        "controller": player
      };
      setState(() => audios.add(temp));
    }
  }

  Widget singleAudioCard(Map audio) {
    return SizedBox.square(
      dimension: 210,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: themeCardColor(),
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              child: Image.memory(
                audio["pic"],
                color: audio["controller"].state == PlayerState.playing
                    ? themeTxtColor()
                    : themeBgColor(),
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              ),
              onTap: () async {
                print("My previous state is :${audio["controller"].state}");
                if (audio["controller"].state == PlayerState.paused ||
                    audio["controller"].state == PlayerState.stopped ||
                    audio["controller"].state == PlayerState.completed) {
                  await audio["controller"].resume();
                  (context as Element).reassemble();
                } else if (audio["controller"].state == PlayerState.playing) {
                  await audio["controller"].pause();
                  (context as Element).reassemble();
                }
                print("Hello there! This is me: ${audio["name"]}");
                print("Now my state is :${audio["controller"].state}");
              },
            ),
            Slider(
              activeColor: audio["controller"].state == PlayerState.playing
                  ? invertedThemeTxtColor()
                  : themeBgColor(),
              thumbColor: audio["controller"].state == PlayerState.playing
                  ? invertedThemeTxtColor()
                  : themeBgColor(),
              min: 0,
              max: 100,
              value: audio["volume"],
              onChanged: (value) async {
                print("My previous volume was ${audio["volume"]}");
                setState(() {
                  audio["volume"] = value;
                });
                await audio["controller"].setVolume(value / 100);
                print("Now my volume was ${audio["volume"]}");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget mainPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextLiquidFill(
                text: "JUST RELAX",
                boxHeight: MediaQuery.of(context).size.height / 3,
                boxWidth: MediaQuery.of(context).size.width / 3,
                waveColor: themeTxtColor().withOpacity(0.8),
                boxBackgroundColor: themeCardColor(),
                loadDuration: const Duration(seconds: 120),
                textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 7,
                  color: invertedThemeTxtColor(),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Loaded ${audios.length} soothing sounds to ",
                  style: TextStyle(
                    color: themeTxtColor().withOpacity(0.5),
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(width: 4),
                DefaultTextStyle(
                  style: TextStyle(
                    color: themeTxtColor().withOpacity(0.5),
                    fontSize: 40,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    pause: const Duration(milliseconds: 500),
                    animatedTexts: [
                      RotateAnimatedText('FOCUS'),
                      RotateAnimatedText('STUDY'),
                      RotateAnimatedText('MEDITATE'),
                      RotateAnimatedText('BE PRODUCTIVE'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (var audio in audios) singleAudioCard(audio),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBgColor(),
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: features[2],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: mainPage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: stopAll,
        elevation: 20,
        label: const Text("Stop All"),
        icon: const Icon(Icons.stop),
      ),
    );
  }
}
