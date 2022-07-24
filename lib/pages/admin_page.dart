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

  void singleUserSheet(var user) {
    showModalBottomSheet(
      context: context,
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
                subtitle: Text(
                  "",
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

  void allUsersSheet() async {
    int userbaseSize = await AdminFirestoreServices().getUserbaseSize();
    List userList = await AdminFirestoreServices().listAllUsers();
    showModalBottomSheet(
      backgroundColor: themeBgColor(),
      elevation: 20,
      context: context,
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
          Text(
            "Userbase related !",
            style: TextStyle(color: themeTxtColor()),
          ),
          singleButton(() => allUsersSheet(), "List all User"),
          Text(
            "Data related !",
            style: TextStyle(color: themeTxtColor()),
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
