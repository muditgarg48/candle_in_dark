import 'package:flutter/material.dart';

import 'package:curved_drawer_fork/curved_drawer_fork.dart';

Widget myDrawer() {
  return CurvedDrawer(
    color: Colors.white,
    isEndDrawer: true,
    labelColor: Colors.black54,
    width: 75.0,
    items: const [
      DrawerItem(icon: Icon(Icons.people), label: "person"),
      //Optional Label Text
      DrawerItem(icon: Icon(Icons.message), label: "Messages")
    ],
    onTap: (index) {
      //Handle button tap
    },
  );
}
