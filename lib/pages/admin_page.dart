import 'package:flutter/material.dart';

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
  
  // Widget getAllUsers() {
    
  // }
  
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
      backgroundColor: themeBgColor().withOpacity(0.5),
      body: const Center(child: Text("Hi")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AdminServices().logoutAdmin();
          Navigator.pop(context);
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.logout),
            SizedBox(width: 2),
            Text("Logout"),
          ],
        ),
      ),
    );
  }
}
