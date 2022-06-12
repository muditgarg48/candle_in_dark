import 'package:flutter/material.dart';

import 'theme_data.dart';

class MyBottomNavbar1 extends StatelessWidget {
  const MyBottomNavbar1({
    Key? key,
    required this.pages,
    required this.currentPageIndex,
    required this.setPageIndex,
  }) : super(key: key);

  final int currentPageIndex;
  final List pages;
  final dynamic setPageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: themeBgColor(),
      currentIndex: currentPageIndex,
      type: BottomNavigationBarType.shifting,
      elevation: 15,
      selectedItemColor: themeTxtColor(),
      selectedIconTheme: const IconThemeData(opacity: 1),
      unselectedItemColor: themeTxtColor(),
      unselectedIconTheme: const IconThemeData(opacity: 0.3),
      onTap: setPageIndex,
      items: [
        for (var page in pages)
          BottomNavigationBarItem(
            icon: Icon(page["icon"]),
            activeIcon: Icon(page["active_icon"]),
            tooltip: page["labelName"],
            backgroundColor: themeBgColor(),
            label: page["labelName"],
          ),
      ],
    );
  }
}
