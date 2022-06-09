//Packages
import "package:flutter/material.dart";

//Pages
import './pages/currency_convert_page.dart';
import './pages/dummy_page.dart';

//Pages and their Classes
var pages = const <Map<String, dynamic>>[
  // PageModel(DummyPage(), "Dummy Page", Icon(Icons.texture_sharp)),
  {
    'class': DummyPage(),
    'labelName': "Dummy",
    'icon': Icon(Icons.texture_sharp),
  },
  {
    'class': DummyPage(),
    'labelName': "Dummy",
    'icon': Icon(Icons.texture_sharp),
  },
  {
    'class': CurrencyConvertorPage(),
    'labelName': "Forex",
    'icon': Icon(Icons.attach_money_sharp),
  },
  {
    'class': DummyPage(),
    'labelName': "Dummy",
    'icon': Icon(Icons.texture_sharp),
  },
  {
    'class': DummyPage(),
    'labelName': "Dummy",
    'icon': Icon(Icons.texture_sharp),
  },
];
