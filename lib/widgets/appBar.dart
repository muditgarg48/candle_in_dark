import 'package:flutter/material.dart';

import 'package:candle_in_dark/global_values.dart';

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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      pinned: true,
      floating: true,
      snap: false,
      elevation: 30,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: isDark ? kToDark.shade900 : kToLight.shade900,
          ),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: Image.network(
          appBarBG,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
