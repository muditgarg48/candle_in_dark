import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

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
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LoadingAnimationWidget.dotsTriangle(
          color: Colors.white,
          size: MediaQuery.of(context).size.height / 3,
        ),
      ),
    );
  }
}
