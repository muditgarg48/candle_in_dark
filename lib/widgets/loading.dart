import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../global_values.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  State<LoaderPage> createState() => LoaderPageState();
}

class LoaderPageState extends State<LoaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: isDark ? kToDark.shade600 : kToLight.shade600,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
          child: Center(
            child: LoadingAnimationWidget.fallingDot(
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 3,
            ),
          ),
        ),
      ),
    );
  }
}
