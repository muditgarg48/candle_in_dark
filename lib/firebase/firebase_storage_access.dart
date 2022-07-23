// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../firebase/firebase_options.dart';

Future<void> initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => print("Firebase Initialised!"));
}

void checkFirebaseInstance() async {
  try {
    Firebase.app();
    print("Firebase is already initialised !");
  } catch (exception) {
    print("You again forgot to initialise Firebase !");
    await initialiseFirebase();
    print("Initialised Firebase for you, you're welcome !");
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
