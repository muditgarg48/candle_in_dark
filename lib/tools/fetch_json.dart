
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

dynamic fetchFromJSON(String link) async {
  Response response =
        await get(Uri.parse(link));
  var data = jsonDecode(response.body);
  return data;
}