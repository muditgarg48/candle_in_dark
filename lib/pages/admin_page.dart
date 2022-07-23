import 'package:flutter/material.dart';

import '../firebase/cloud_firestore_access.dart';
import '../tools/account_handle.dart';
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
              Text(
                "Total number of users: $userbaseSize",
                style: TextStyle(
                  color: themeTxtColor(),
                ),
              ),
              for (var user in userList)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    divider(),
                    Text(
                      user["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeTxtColor(),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "ID: ${user["uid"]}",
                      style: TextStyle(
                        color: themeTxtColor(),
                      ),
                    ),
                    Text(
                      "Email ID: ${user["email"]}",
                      style: TextStyle(
                        color: themeTxtColor(),
                      ),
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
