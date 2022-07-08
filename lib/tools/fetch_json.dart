import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:flutter/services.dart';

//from link
// ignore: non_constant_identifier_names
Future fetchFromJSON_Online(String link) async {
  Response response = await get(Uri.parse(link));
  var data = jsonDecode(response.body);
  return data;
}

//from local
// ignore: non_constant_identifier_names
Future fetchFromJSON_Local(String link) async {
  var file = await rootBundle.loadString(link);
  var data = jsonDecode(file);
  return data;
}
