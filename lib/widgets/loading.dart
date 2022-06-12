import 'package:candle_in_dark/widgets/theme_data.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: themeBgColor(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
          child: Center(
            child: LoadingAnimationWidget.fallingDot(
              color: themeTxtColor(),
              size: MediaQuery.of(context).size.height / 3,
            ),
          ),
        ),
      ),
    );
  }
}
