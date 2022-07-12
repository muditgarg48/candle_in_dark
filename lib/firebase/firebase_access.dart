// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../firebase/firebase_options.dart';

void initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // ignore: avoid_print
  ).whenComplete(() => print("Firebase Initialised!"));
}

bool checkFirebaseInstance() {
  try {
    Firebase.app();
    return true;
  } catch (exception) {
    return false;
  }
}

//get JSON data from firebase
Future<dynamic> getFromFirebase_JSON({required String linkFromRoot}) async {
  Reference ref = FirebaseStorage.instance.ref().child(linkFromRoot);
  Uint8List? downloadedData = await ref.getData();
  var jsonData = json.decode(utf8.decode(downloadedData!));
  return jsonData;
}

Future<String> getFromFirebase_FileURL({required String linkFromRoot}) {
  Reference ref = FirebaseStorage.instance.ref().child(linkFromRoot);
  return ref.getDownloadURL();
}

Future<Uint8List?> getFromFirebase_File({required String linkFromRoot}) async {
  Reference ref = FirebaseStorage.instance.ref().child(linkFromRoot);
  Uint8List? fileBytes;
  await ref.getData().then((data) => fileBytes = data);
  return fileBytes;
}
