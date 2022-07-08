// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../tools/cache.dart';
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
    return cacheImage(appBarBG);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
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
