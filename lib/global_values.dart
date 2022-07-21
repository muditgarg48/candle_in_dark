//Packages
// ignore_for_file: non_constant_identifier_names

import "package:flutter/material.dart";

//Pages
import './pages/currency_convert_page.dart';
import './pages/world_clock.dart';
import './pages/dummy_page.dart';
// import './pages/about.dart';
import './pages/imp_links.dart';
import './pages/home_page.dart';
import './pages/settings.dart';
import 'pages/focus_page.dart';
import 'pages/faculty.dart';
import 'pages/network_page.dart';
import 'widgets/admin.dart';

String versionNumber = "1.0.0";

//Pages and their Classes
var pages = <Map<String, dynamic>>[
  {
    //0
    'route_name': 'index',
    'route': (context) => const MyHomePage(),
    'class': const MyHomePage(),
    'labelName': "Home Page",
    'active_icon': Icons.home,
    'icon': Icons.home_outlined,
    'appBarTitle': "WELCOME",
    'appBarBG': "",
  },
  // {
  //   //0
  //   'route_name': 'about',
  //   'route': (context) => const AboutPage(),
  //   'class': const AboutPage(),
  //   'labelName': "About Page",
  //   'active_icon': Icons.info,
  //   'icon': Icons.info_outlined,
  //   'appBarTitle': "ABOUT",
  //   'appBarBG':
  //       "https://images.unsplash.com/photo-1565246075196-94d3995a0b37?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80",
  // },
  {
    //1
    'route_name': 'dummy',
    'route': (context) => const DummyPage(),
    'class': const DummyPage(),
    'labelName': "Dummy Page",
    'active_icon': Icons.texture_sharp,
    'icon': Icons.texture_outlined,
    'appBarTitle': "PLACEHOLDER PAGE",
    'appBarBG':
        "https://miro.medium.com/max/1400/1*WmSNhK1BGctLUuXFVnV8pw.jpeg",
  },
  {
    //2
    'route_name': 'imp_links',
    'route': (context) => const ImpLinksPage(),
    'class': const ImpLinksPage(),
    'labelName': "Quick Links",
    'active_icon': Icons.alternate_email,
    'icon': Icons.alternate_email_sharp,
    'appBarTitle': "IMPORTANT LINKS",
    'appBarBG': "https://cdn.hswstatic.com/gif/web-addresses-english-orig.jpg",
  },
  {
    //3
    'route_name': 'faculty',
    'route': (context) => const TheFacultyPage(),
    'class': const TheFacultyPage(),
    'labelName': "Know your Faculty",
    'active_icon': Icons.people_alt_outlined,
    'icon': Icons.people_outline_outlined,
    'appBarTitle': "KNOW YOUR FACULTY",
    'appBarBG':
        "https://images.unsplash.com/photo-1505663912202-ac22d4cb3707?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  }
  // {
  //   //4
  //   'route_name': 'imp_pdfs',
  //   'route': (context) => const ImpPDFsPage(),
  //   'class': const ImpPDFsPage(),
  //   'labelName': "Important PDFs",
  //   'active_icon': Icons.picture_as_pdf,
  //   'icon': Icons.picture_as_pdf_outlined,
  //   'appBarTitle': "IMPORTANT PDFs",
  //   'appBarBG':
  //       "https://images.unsplash.com/photo-1651936716527-c92d541cf630?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
  // },
];

var features = <Map<String, dynamic>>[
  {
    //0
    'route_name': 'world_clock',
    'route': (context) => const WorldClock(),
    'class': const WorldClock(),
    'labelName': "World Clock",
    'active_icon': Icons.timer_sharp,
    'icon': Icons.timer_outlined,
    'appBarTitle': "WORLD CLOCK",
    'appBarBG':
        "https://images.unsplash.com/photo-1502920514313-52581002a659?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1167&q=80",
  },
  {
    //1
    'route_name': 'forex',
    'route': (context) => const CurrencyConvertorPage(),
    'class': const CurrencyConvertorPage(),
    'labelName': "Currency Convertor",
    'active_icon': Icons.attach_money_sharp,
    'icon': Icons.attach_money_outlined,
    'appBarTitle': "CURRENCY CONVERTOR",
    'appBarBG':
        "https://images.unsplash.com/photo-1599690925058-90e1a0b56154?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1965&q=80",
  },
  {
    //2
    'route_name': 'calm',
    'route': (context) => const CalmPage(),
    'class': const CalmPage(),
    'labelName': "Focus",
    'active_icon': Icons.music_note_rounded,
    'icon': Icons.music_note_outlined,
    'appBarTitle': "",
    'appBarBG': "",
  },
  {
    //3
    'route_name': 'network',
    'route': (context) => const NetworkPage(),
    'class': const NetworkPage(),
    'labelName': "Network with people",
    'active_icon': Icons.messenger_rounded,
    'icon': Icons.messenger_outline_rounded,
    'appBarTitle': "Network with people",
    'appBarBG':
        "https://images.unsplash.com/photo-1530811761207-8d9d22f0a141?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  },
];

var settings = <String, dynamic>{
  'route_name': 'settings',
  'route': (context) => const SettingsPage(),
  'class': const SettingsPage(),
  'labelName': "Settings",
  'active_icon': Icons.settings,
  'icon': Icons.settings_outlined,
  'appBarTitle': "SETTINGS",
  'appBarBG':
      "https://clipart.world/wp-content/uploads/2020/08/gears-setting-icon-png-transparent.png",
};

var admin_console = <String, dynamic>{
  'route_name': 'admin',
  'route': (context) => const AdminsPage(),
  'class': const AdminsPage(),
  'labelName': "Admin Console",
  'active_icon': Icons.admin_panel_settings_rounded,
  'icon': Icons.admin_panel_settings_outlined,
  'appBarTitle': "",
  'appBarBG':
      "",
};

var appRoutes = <String, Widget Function(BuildContext)>{
  for (var page in pages) page['route_name']: page['route'],
  for (var feature in features) feature['route_name']: feature['route'],
  settings["route_name"]: settings['route'],
  admin_console["route_name"]: admin_console['route'],
};

//Theme Variables
ThemeMode themeMode = ThemeMode.light;
IconData themeIcon = Icons.sunny;
bool isDark = false;
bool systemBasedTheme = false;

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

bool isAdmin = false;
