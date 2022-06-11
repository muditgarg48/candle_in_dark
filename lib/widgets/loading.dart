import 'package:candle_in_dark/widgets/theme_data.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../global_values.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => LoadingState();
}

class LoadingState extends State<Loading> {
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
