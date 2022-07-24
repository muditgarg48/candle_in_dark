import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  void addUserToDatabase({
    String? uid,
    String? name,
    required String email,
    String? photoURL,
  }) async {
    final user = FirebaseFirestore.instance.collection("users").doc(uid);
    final userData = {
      'uid': uid,
      'name': name,
      'email': email,
      'photoURL': photoURL ??
          "https://form.wittenborg.eu/sites/default/files/inline-images/wb-avatar.png",
    };
    await user.set(userData);
  }
}

class AdminFirestoreServices {
  Future<int> getUserbaseSize() async {
    var userList = await FirebaseFirestore.instance.collection("users").get();
    return userList.size;
  }

  Future<List> listAllUsers() async {
    var userList = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("uid")
        .get();
    var userListJSON =
        userList.docs.map((userSnapshot) => userSnapshot.data()).toList();
    return userListJSON;
  }

  Future<Map> getSingleUserDetails(String uid) async {
    var user =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    var userData = user.data() as Map;
    return userData;
  }

  Future<List> listAllImpLinkSections() async {
    var linkSections =
        await FirebaseFirestore.instance.collection("imp_links").get();
    var linkSectionListJSON =
        linkSections.docs.map((userSnapshot) => userSnapshot.data()).toList();
    return linkSectionListJSON;
  }

  Future addLink(String name, String link, String id) async {
    var section = FirebaseFirestore.instance.collection("imp_links").doc(id);
    var linkSection = (await section.get()).data();
    var currentLink = {
      'name': name,
      'link': link,
    };
    List linksArray = linkSection!["links"];
    linksArray.add(currentLink);
    section.update({"links": linksArray});
  }
}
