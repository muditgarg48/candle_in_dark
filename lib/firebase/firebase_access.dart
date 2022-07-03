import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//get JSON data from firebase
Future<dynamic> getJSON({required String linkFromRoot}) async {
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(linkFromRoot);
  Uint8List? downloadedData = await ref.getData();
  var jsonData = json.decode(utf8.decode(downloadedData!));
  return jsonData;
}
