//Packages
// ignore_for_file: invalid_use_of_protected_member

import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_access.dart';
import '../tools/theme.dart';

import '../widgets/font_styles.dart';
import '../widgets/drawer.dart';

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
    checkFirebaseInstance();
    getAudioJSON();
    super.initState();
  }

  @override
  void dispose() {
    stopAll();
    disposeAllPlayers();
    super.dispose();
  }

  void playPausedOnes() {
    for (var audio in audios) {
      if (audio["controller"].state == PlayerState.paused) {
        audio["controller"].resume();
      }
    }
    (context as Element).reassemble();
  }

  void pauseAll() {
    for (var audio in audios) {
      if (audio["controller"].state == PlayerState.playing) {
        audio["controller"].pause();
      }
    }
    (context as Element).reassemble();
  }

  void stopAll() {
    for (var audio in audios) {
      audio["controller"].stop();
      audio["volume"] = 0.4;
    }
    (context as Element).reassemble();
  }

  void disposeAllPlayers() {
    for (var audio in audios) {
      audio["controller"].dispose();
    }
  }

  void getAudioJSON() async {
    // List fileData = await fetchFromJSON_Local("assets/json/calm_audios.json");
    List fileData =
        await getFromFirebase_JSON(linkFromRoot: "json/calm_audios.json");
    // print("MY DATA: $fileData");
    setState(() => audioNames = fileData);
    await mapAudios();
  }

  Future<Uint8List> getIcon(String name) async {
    Uint8List imgBytes = (await getFromFirebase_File(linkFromRoot: name))!;
    return imgBytes;
  }

  Future<void> mapAudios() async {
    for (var audioName in audioNames) {
      var pic = await getIcon("audios/icons/$audioName.png");
      var audioLink = await getFromFirebase_FileURL(
          linkFromRoot: "audios/ogg/$audioName.ogg");
      var player = AudioPlayer(playerId: audioName);
      await player.setSourceUrl(audioLink);
      player.setPlayerMode(PlayerMode.lowLatency);
      player.setVolume(0.4);
      var temp = {
        "name": audioName,
        "pic": pic,
        "volume": 0.4,
        "controller": player
      };
      setState(() => audios.add(temp));
    }
  }

  Widget singleAudioCard(Map audio) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox.square(
      dimension: width / 3 > 210 ? 210 : 150,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: themeCardColor().withOpacity(0.5),
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              child: Image.memory(
                audio["pic"],
                color: audio["controller"].state == PlayerState.playing
                    ? themeTxtColor().withOpacity(0.7)
                    : themeBgColor().withOpacity(0.5),
                fit: BoxFit.fill,
                height: width / 3 > 210 ? 100 : 50,
                width: width / 3 > 210 ? 100 : 50,
              ),
              onTap: () async {
                // print("My previous state is :${audio["controller"].state}");
                if (audio["controller"].state == PlayerState.paused ||
                    audio["controller"].state == PlayerState.stopped ||
                    audio["controller"].state == PlayerState.completed) {
                  await audio["controller"].resume();
                  (context as Element).reassemble();
                } else if (audio["controller"].state == PlayerState.playing) {
                  await audio["controller"].pause();
                  (context as Element).reassemble();
                }
                // print("Hello there! This is me: ${audio["name"]}");
                // print("Now my state is :${audio["controller"].state}");
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
              value: audio["volume"] * 100,
              onChanged: (value) async {
                // print("My previous volume was ${audio["volume"]}");
                setState(() {
                  audio["volume"] = value / 100;
                });
                await audio["controller"].setVolume(value / 100);
                // print("Now my volume was ${audio["volume"]}");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget titleCard(String txt, Color bg) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(width / 30),
      child: Container(
        alignment: Alignment.center,
        color: bg,
        height: height / 5,
        width: width / 2,
        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: appFont(
            fontDesign: TextStyle(
              color: themeTxtColor(),
              fontSize: width / 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget mainPage() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 20,
            ),
            titleCard("FOCUS", Colors.transparent),
            SizedBox(
              height: height / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: audioNames.isEmpty
                      ? Text(
                          "Loading our list of soothing sounds for you to ",
                          style: TextStyle(
                            color: themeTxtColor().withOpacity(0.5),
                            fontSize: width / 10 > 150 ? 40 : 20,
                          ),
                          textAlign: TextAlign.end,
                        )
                      : Text(
                          "Try to",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: themeTxtColor().withOpacity(0.5),
                            fontSize: width / 10 > 150 ? 40 : 20,
                          ),
                          textAlign: TextAlign.end,
                        ),
                ),
                const Expanded(flex: 0, child: SizedBox(width: 7)),
                Expanded(
                  flex: 5,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeTxtColor().withOpacity(0.8),
                      fontSize: width / 10 > 150 ? 40 : 20,
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      pause: const Duration(seconds: 1),
                      animatedTexts: [
                        FadeAnimatedText('STUDY'),
                        FadeAnimatedText('MEDITATE'),
                        FadeAnimatedText('RELAX'),
                        FadeAnimatedText('SLEEP'),
                        FadeAnimatedText('FOCUS'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 20,
            ),
            audios.isNotEmpty
                ? Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (var audio in audios) singleAudioCard(audio),
                    ],
                  )
                : const SizedBox.shrink(),
            audios.length != audioNames.length
                ? Text(
                    "Loaded ${audios.length}/${audioNames.length} soothing sounds",
                    style: TextStyle(
                      backgroundColor: themeBgColor().withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      color: themeTxtColor().withOpacity(0.5),
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.end,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  dynamic globalActionButton(
      String message, IconData icon, VoidCallback action) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: width / 40 > 20
          ? FloatingActionButton.extended(
              onPressed: action,
              elevation: 20,
              backgroundColor: themeBgColor().withOpacity(0.4),
              label: Text(
                message,
                style: TextStyle(color: themeTxtColor()),
              ),
              icon: Icon(icon, color: themeTxtColor()),
            )
          : FloatingActionButton(
              onPressed: action,
              tooltip: message,
              backgroundColor: themeBgColor(),
              child: Icon(icon),
            ),
    );
  }

  Widget scaffold() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: features[2],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mainPage(),
      ),
      backgroundColor: kToDark.shade600.withOpacity(0.5),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          globalActionButton(
              "Try our curated playlists", Icons.playlist_play_rounded, () {}),
          globalActionButton(
              "Play paused", Icons.play_arrow_rounded, playPausedOnes),
          globalActionButton("Pause playing", Icons.pause_rounded, pauseAll),
          globalActionButton("Stop All", Icons.stop_rounded, stopAll),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget background() {
    return SizedBox.expand(
      child: Image.asset(
        isDark ? "assets/imgs/focus_dark.jpg" : "assets/imgs/focus_light.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),
        scaffold(),
      ],
    );
  }
}
