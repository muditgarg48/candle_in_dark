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
  ).whenComplete(() => print("FireBase Initialised!"));
}

//get JSON data from firebase
Future<dynamic> getJSON_FromFirebase({required String linkFromRoot}) async {
  Reference ref = FirebaseStorage.instance.ref().child(linkFromRoot);
  Uint8List? downloadedData = await ref.getData();
  var jsonData = json.decode(utf8.decode(downloadedData!));
  return jsonData;
}

Future<Uint8List?> getPDF_FromFirebase({required String linkFromRoot}) async {

  Reference ref =
      FirebaseStorage.instanceFor(bucket: "candle-in-dark.appspot.com")
          .refFromURL("gs://candle-in-dark.appspot.com/$linkFromRoot");
  // Reference ref = FirebaseStorage.instance.ref().child(linkFromRoot);
  Uint8List? pdfAsBytes;
  await ref.getData(104857600).then((value) => pdfAsBytes = value);
  return pdfAsBytes;
}
