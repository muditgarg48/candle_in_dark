import 'package:flutter/material.dart';

import '../../widgets/theme_data.dart';

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

  BottomNavigationBarItem pageItem(dynamic page) {
    return BottomNavigationBarItem(
      icon: Icon(page["icon"]),
      activeIcon: Icon(page["active_icon"]),
      tooltip: page["labelName"],
      backgroundColor: themeBgColor(),
      label: page["labelName"],
    );
  }

  Widget actualBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: themeBgColor(),
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.shifting,
        elevation: 15,
        selectedItemColor: themeTxtColor(),
        selectedIconTheme: const IconThemeData(opacity: 1),
        unselectedItemColor: themeTxtColor(),
        unselectedIconTheme: const IconThemeData(opacity: 0.3),
        onTap: setPageIndex,
        items: [for (var page in pages) pageItem(page)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: actualBar(),
    );
  }
}
