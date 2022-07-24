import 'package:flutter/material.dart';

import '../firebase/cloud_firestore_access.dart';
import '../tools/account_handle.dart';
import '../tools/cache.dart';
import '../tools/theme.dart';
import '../widgets/drawer.dart';
import '../global_values.dart';

class AdminsPage extends StatefulWidget {
  const AdminsPage({Key? key}) : super(key: key);

  @override
  State<AdminsPage> createState() => _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage> {
  Widget divider() {
    return Divider(
      color: themeTxtColor(),
      endIndent: MediaQuery.of(context).size.width / 10,
      indent: MediaQuery.of(context).size.width / 10,
    );
  }

  Widget singleButton(VoidCallback purpose, String txt) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shape: const StadiumBorder(),
          primary: themeButtonColor(),
          onPrimary: themeTxtColor(),
        ),
        onPressed: purpose,
        child: Text(txt),
      ),
    );
  }
  /*
  ===========================
  USERBASE RELATED FUNCTIONS
  ===========================
  */

  void singleUserSheet(var user) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(15),
          color: themeBgColor(),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: themeBgColor(),
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: cacheImage(user["photoURL"]),
                ),
              ),
              Text(
                user["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color:
                      user["uid"] == "admin" ? Colors.amber : themeTxtColor(),
                ),
              ),
              divider(),
              Text(
                "ID: ${user["uid"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color:
                      user["uid"] == "admin" ? Colors.amber : themeTxtColor(),
                ),
              ),
              Text(
                "Mail: ${user["email"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color:
                      user["uid"] == "admin" ? Colors.amber : themeTxtColor(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void userActionSheet(var user) {
    if (user["uid"] == "admin") return;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          color: themeBgColor(),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                user["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              divider(),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Show his account metadata",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Show Profile Card",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () => singleUserSheet(user),
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  "Delete his account",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Note: This operation is irreversible",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "Add a detail to his account?",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void allUsersSheet() async {
    int userbaseSize = await AdminFirestoreServices().getUserbaseSize();
    List userList = await AdminFirestoreServices().listAllUsers();
    showModalBottomSheet(
      backgroundColor: themeBgColor(),
      elevation: 20,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Text(
                "Your Users",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Total number of users: $userbaseSize",
                style: TextStyle(
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              for (var user in userList)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    divider(),
                    ListTile(
                      horizontalTitleGap:
                          MediaQuery.of(context).size.width / 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      tileColor: themeCardColor().withOpacity(0.8),
                      textColor: user["uid"] == "admin"
                          ? Colors.amber
                          : themeTxtColor(),
                      leading: CircleAvatar(
                        backgroundColor: themeBgColor(),
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: themeTxtColor(),
                        ),
                      ),
                      title: Text(
                        user["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(user["email"]),
                      onTap: () => singleUserSheet(user),
                      onLongPress: () => userActionSheet(user),
                    ),
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  /*
  =================================
  IMPORTANT LINKS RELATED FUNCTIONS
  =================================
  */

  void addLinkDialogueBox(var section) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        TextEditingController name = TextEditingController();
        TextEditingController link = TextEditingController();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Link to ${section["name"]} set"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Link Name",
                  suffixIcon: IconButton(
                    onPressed: () => name.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                ),
                controller: name,
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Link URL",
                  suffixIcon: IconButton(
                    onPressed: () => link.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                ),
                controller: link,
                keyboardType: TextInputType.url,
                onEditingComplete: () {
                  AdminFirestoreServices()
                      .addLink(name.text, link.text, section["id"]);
                  Navigator.pop(context);
                },
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              onPressed: () {
                AdminFirestoreServices()
                    .addLink(name.text, link.text, section["id"]);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text("Submit"),
            ),
            Padding(
              padding: MediaQuery.of(context).viewInsets,
            ),
          ],
        );
      },
    );
  }

  void allLinkSectionsSheet() async {
    List impLinkSectionList =
        await AdminFirestoreServices().listAllImpLinkSections();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: themeBgColor(),
      elevation: 20,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Text(
                "Your Link Sections",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              for (var section in impLinkSectionList)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    divider(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      tileColor: themeCardColor().withOpacity(0.8),
                      textColor: themeTxtColor(),
                      leading: CircleAvatar(
                        backgroundColor: themeBgColor(),
                        child: Icon(
                          Icons.document_scanner_rounded,
                          color: themeTxtColor(),
                        ),
                      ),
                      title: Text(
                        section["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle:
                          Text("Number of links: ${section["links"].length}"),
                      onTap: () => singleLinkSection(section),
                      onLongPress: () => singleSectionActionSheet(section),
                    ),
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  void singleLinkSection(var section) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(15),
          color: themeBgColor(),
          child: ListView(
            children: [
              CircleAvatar(
                backgroundColor: themeBgColor(),
                radius: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: cacheImage(section["photo_link"]),
                ),
              ),
              Text(
                section["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: themeTxtColor(),
                ),
              ),
              divider(),
              for (var link in section["links"])
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  tileColor: invertedThemeTxtColor().withOpacity(0.8),
                  textColor: themeTxtColor(),
                  title: Text(
                    link["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(link["link"]),
                  onTap: () => singleLinkActionSheet(link),
                ),
            ],
          ),
        );
      },
    );
  }

  void singleLinkActionSheet(var link) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          color: themeBgColor(),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                link["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                link["link"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              divider(),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Edit Link Data",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Change link attributes",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.copy_rounded,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "Copy Link",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Copy link to clipboard",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  "Delete link",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Note: This operation is irreversible",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  void singleSectionActionSheet(var section) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          color: themeBgColor(),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                section["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: themeTxtColor(),
                ),
              ),
              const SizedBox(height: 10),
              divider(),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Show link section",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Show links under this section",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () => singleLinkSection(section),
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  "Delete this link section",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                subtitle: Text(
                  "Note: This operation is irreversible",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "Add a link to this section",
                  style: TextStyle(
                    color: themeTxtColor(),
                  ),
                ),
                onTap: () => addLinkDialogueBox(section),
              ),
            ],
          ),
        );
      },
    );
  }
  /*
  =================================
  WHOLE PAGE RELATED FUNCTIONS
  =================================
  */

  Widget mainPage() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Text(
            "Admin Panel",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: themeTxtColor(),
            ),
          ),
          divider(),
          const SizedBox(height: 20),
          Card(
            color: themeCardColor(),
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "User Base related !",
                      style: TextStyle(
                        color: themeTxtColor(),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  divider(),
                  singleButton(() => allUsersSheet(), "Fetch Userbase List"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: themeCardColor(),
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Data related !",
                      style: TextStyle(
                        color: themeTxtColor(),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  divider(),
                  singleButton(() => allLinkSectionsSheet(),
                      "Fetch Important Links Data"),
                  singleButton(() {}, "Fetch Faculty Data Stored"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget logoutButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        AdminServices().logoutAdmin();
        Navigator.pop(context);
      },
      backgroundColor: themeButtonColor(),
      icon: Icon(Icons.logout, color: themeTxtColor()),
      label: Text(
        "Logout",
        style: TextStyle(color: themeTxtColor()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: admin_console,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: themeBgColor(),
      body: mainPage(),
      floatingActionButton: logoutButton(),
    );
  }
}
