//Packages
import "package:flutter/material.dart";
import 'package:frankfurter/frankfurter.dart';

//Pages
import './pages/currency_convert_page.dart';
import './pages/world_clock.dart';
import './pages/dummy_page.dart';

//Pages and their Classes
var pages = <Map<String, dynamic>>[
  {
    'route_name': 'dummy',
    'route': (context) => DummyPage(),
    'class': DummyPage(),
    'labelName': "Dummy Page",
    'active_icon': Icons.texture_sharp,
    'icon': Icons.texture_outlined,
  },
  {
    'route_name': 'dummy',
    'route': (context) => DummyPage(),
    'class': DummyPage(),
    'labelName': "Dummy Page",
    'active_icon': Icons.texture_sharp,
    'icon': Icons.texture_outlined,
  },
  {
    'route_name': 'world_clock',
    'route': (context) => WorldClock(),
    'class': WorldClock(),
    'labelName': "World Clock",
    'active_icon': Icons.timer_sharp,
    'icon': Icons.timer_outlined,
  },
  {
    'route_name': 'forex',
    'route': (context) => CurrencyConvertorPage(),
    'class': CurrencyConvertorPage(),
    'labelName': "Currency Convertor",
    'active_icon': Icons.attach_money_sharp,
    'icon': Icons.attach_money_outlined,
  },
  {
    'route_name': 'dummy',
    'route': (context) => DummyPage(),
    'class': DummyPage(),
    'labelName': "Dummy Page",
    'active_icon': Icons.texture_sharp,
    'icon': Icons.texture_outlined,
  },
  {
    'route_name': 'dummy',
    'route': (context) => DummyPage(),
    'class': DummyPage(),
    'labelName': "Dummy Page",
    'active_icon': Icons.texture_sharp,
    'icon': Icons.texture_outlined,
  },
];

//Theme Variables
ThemeMode themeMode = ThemeMode.light;
IconData themeIcon = Icons.sunny;
bool isDark = false;

MaterialColor kToLight = const MaterialColor(
  0xff009ffd, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  {
    50: Color(0xff1aa9fd), //10%
    100: Color(0xff33b2fd), //20%
    200: Color(0xff4dbcfe), //30%
    300: Color(0xff66c5fe), //40%
    400: Color(0xff80cffe), //50%
    500: Color(0xff99d9fe), //60%
    600: Color(0xffb3e2fe), //70%
    700: Color(0xffccecff), //80%
    800: Color(0xffe6f5ff), //90%
    900: Color(0xffffffff), //100%
  },
);

MaterialColor kToDark = const MaterialColor(
  0xff009ffd, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  {
    50: Color(0xff008fe4), //10%
    100: Color(0xff007fca), //20%
    200: Color(0xff006fb1), //30%
    300: Color(0xff005f98), //40%
    400: Color(0xff00507f), //50%
    500: Color(0xff004065), //60%
    600: Color(0xff00304c), //70%
    700: Color(0xff002033), //80%
    800: Color(0xff001019), //90%
    900: Color(0xff000000), //100%
  },
);
