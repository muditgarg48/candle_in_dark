import 'package:flutter/material.dart';

import 'package:curved_drawer_fork/curved_drawer_fork.dart';

import '../global_values.dart';

Widget myDrawer(BuildContext context) {
  return CurvedDrawer(
    color: Theme.of(context).backgroundColor,
    isEndDrawer: false,
    labelColor: isDark ? kToDark.shade900 : kToLight.shade900,
    width: 55,
    buttonBackgroundColor: Theme.of(context).backgroundColor,
    backgroundColor: Colors.transparent,
    items: [
      for (var page in pages)
        DrawerItem(
          label: page["labelName"],
          icon: Icon(page["icon"]),
        ),
    ],
    onTap: (index) {
      //Handle button tap
    },
  );
}
