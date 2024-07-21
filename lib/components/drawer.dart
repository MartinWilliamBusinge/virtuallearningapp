import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/components/my_list_tile.dart';
import 'package:virtuallearningapp/pages/downloads_page.dart';
import 'package:virtuallearningapp/pages/profile_page.dart';
import 'package:virtuallearningapp/pages/year_one.dart';
import 'package:virtuallearningapp/pages/year_two.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 78, 59, 114),
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "W E L C O M E",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  MyListTile(
                    icon: Icons.home,
                    text: 'H O M E',
                    onTap: () => Navigator.pop(context),
                  ),
                  MyListTile(
                    icon: Icons.download_rounded,
                    text: "DOWNLOADS ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DownloadPage(),
                      ));
                    },
                  ),
                  MyListTile(
                    icon: Icons.looks_one_rounded,
                    text: "Y E A R  O N E  ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const YearOnePage(),
                      ));
                    },
                  ),
                  MyListTile(
                    icon: Icons.looks_two_rounded,
                    text: "Y E A R  T W O ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const YearTwoPage(),
                      ));
                    },
                  ),
                  MyListTile(
                    icon: Icons.person,
                    text: "P R O F I L E ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
            MyListTile(
              icon: Icons.logout,
              text: "L O G  O U T ",
              onTap: signUserOut,
            ),
          ],
        ),
      ),
    );
  }
}
