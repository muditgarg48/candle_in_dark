import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../tools/theme.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.display}) : super(key: key);

  final String display;

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  Widget fetchRandomLoadingAnimation({var color, var size}) {
    var loadingAnimations = [
      LoadingAnimationWidget.beat(color: color, size: size),
      LoadingAnimationWidget.bouncingBall(color: color, size: size),
      LoadingAnimationWidget.discreteCircle(color: color, size: size),
      LoadingAnimationWidget.dotsTriangle(color: color, size: size),
      LoadingAnimationWidget.fallingDot(color: color, size: size),
      LoadingAnimationWidget.fourRotatingDots(color: color, size: size),
      LoadingAnimationWidget.halfTriangleDot(color: color, size: size),
      LoadingAnimationWidget.hexagonDots(color: color, size: size),
      LoadingAnimationWidget.horizontalRotatingDots(color: color, size: size),
      LoadingAnimationWidget.inkDrop(color: color, size: size),
      LoadingAnimationWidget.newtonCradle(color: color, size: size),
      LoadingAnimationWidget.prograssiveDots(color: color, size: size),
      LoadingAnimationWidget.staggeredDotsWave(color: color, size: size),
      LoadingAnimationWidget.stretchedDots(color: color, size: size),
      LoadingAnimationWidget.threeArchedCircle(color: color, size: size),
      LoadingAnimationWidget.threeRotatingDots(color: color, size: size),
      LoadingAnimationWidget.twoRotatingArc(color: color, size: size),
      LoadingAnimationWidget.waveDots(color: color, size: size),
    ];
    return loadingAnimations[Random().nextInt(loadingAnimations.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: themeBgColor(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
              child: Center(
                child: fetchRandomLoadingAnimation(
                  color: themeTxtColor(),
                  size: MediaQuery.of(context).size.height / 3,
                ),
              ),
            ),
            Center(
                child: Text(
              widget.display,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: invertedThemeTxtColor(),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
