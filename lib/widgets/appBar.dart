import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../tools/theme.dart';
import '../global_values.dart';

var appBarDecor = const BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(200),
    bottomRight: Radius.circular(200),
  ),
);

// ignore: camel_case_types
class customSliver extends StatelessWidget {
  const customSliver(
      {Key? key, required this.appBarTitle, required this.appBarBG})
      : super(key: key);

  final String appBarTitle;
  final String appBarBG;

  Widget title() {
    return Text(
      appBarTitle,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: themeButtonColor(),
          shadows: [
            Shadow(
              // bottomLeft
              offset: const Offset(-1.2, -1.2),
              color: isDark ? Colors.grey : Colors.black,
            ),
            Shadow(
              // bottomLeft
              offset: const Offset(-1.2, -1.2),
              color: isDark ? Colors.grey : Colors.black,
            ),
            Shadow(
              // bottomLeft
              offset: const Offset(-1.2, -1.2),
              color: isDark ? Colors.grey : Colors.black,
            ),
            Shadow(
              // bottomLeft
              offset: const Offset(-1.2, -1.2),
              color: isDark ? Colors.grey : Colors.black,
            ),
          ]),
    );
  }

  dynamic backgroundImage() {
    return CachedNetworkImage(
      placeholder: (context, url) => LoadingAnimationWidget.inkDrop(
        color: themeTxtColor(),
        size: MediaQuery.of(context).size.height / 10,
      ),
      imageUrl: appBarBG,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      pinned: true,
      floating: true,
      snap: false,
      elevation: 30,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        title: title(),
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: backgroundImage(),
      ),
    );
  }
}
