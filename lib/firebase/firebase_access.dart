import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import '../firebase/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

void initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // ignore: avoid_print
  ).whenComplete(() => print("FireBase Initialised!"));
}

//get JSON data from firebase
Future<dynamic> getJSON({required String linkFromRoot}) async {
  Reference ref = FirebaseStorage.instance.ref().child(linkFromRoot);
  Uint8List? downloadedData = await ref.getData();
  var jsonData = json.decode(utf8.decode(downloadedData!));
  return jsonData;
}
