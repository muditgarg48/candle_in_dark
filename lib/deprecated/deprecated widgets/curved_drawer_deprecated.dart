import '../../pages/home_page.dart';
import '../../widgets/theme_data.dart';
import 'package:flutter/material.dart';

import 'package:curved_drawer_fork/curved_drawer_fork.dart';

import '../../global_values.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    int currentI = 2;
    return CurvedDrawer(
      index: currentI,
      color: themeBgColor(),
      isEndDrawer: false,
      labelColor: themeTxtColor(),
      width: 55,
      buttonBackgroundColor: themeBgColor(),
      backgroundColor: Colors.transparent,
      items: [
        for (var page in pages)
          DrawerItem(
            label: page["labelName"],
            icon: Icon(page["icon"]),
          ),
      ],
      onTap: (index) {
        setState(() {
          currentI = index;
        });
        MyHomePageState().setPageIndex(index);
      },
    );
  }
}
