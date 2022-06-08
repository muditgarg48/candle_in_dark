//Packages
import "package:flutter/material.dart";

//Variables
import "../global_values.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPageIndex = 0;

  void setPageIndex(int index) {
    setState(() => currentPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex]["class"],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.shifting,
        elevation: 15,
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(opacity: 1),
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(opacity: 0.2),
        onTap: setPageIndex,
        items: [
          for (var page in pages)
            BottomNavigationBarItem(
              tooltip: page["labelName"],
              backgroundColor: Theme.of(context).backgroundColor,
              icon: page["icon"],
              label: page["labelName"],
            ),
        ],
      ),
    );
  }
}
