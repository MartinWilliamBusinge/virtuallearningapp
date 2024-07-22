import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/components/my_list_tile.dart';
import 'package:virtuallearningapp/components/settings.dart';
import 'package:virtuallearningapp/pages/downloads_page.dart';
import 'package:virtuallearningapp/pages/year_one_semester_one_page.dart';
import 'package:virtuallearningapp/pages/year_one_semester_two_page.dart';
import 'package:virtuallearningapp/pages/year_two_semester_one_page.dart';
import 'package:virtuallearningapp/pages/year_two_semester_two_page.dart';

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
        color: (Colors.deepPurple.shade400),
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "       “REMEMBER\"\n \nBeing a student is easy.\nLearning requires actual work.” \n     *William Crawford*",
                  style: TextStyle(fontSize: 18, color: Colors.brown.shade900),
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
                    text: "D O W N L O A D S ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DownloadPage(),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.looks_one_rounded),
                    title: const Text("Y E A R  O N E"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'Semester One') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const YearOneSemesterOnePage(),
                          ));
                        } else if (value == 'Semester Two') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const YearOneSemesterTwoPage(),
                          ));
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Semester One', 'Semester Two'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.looks_two_rounded),
                    title: const Text("Y E A R  T W O "),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'Semester One') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const YearTwoSemesterOnePage(),
                          ));
                        } else if (value == 'Semester Two') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const YearTwoSemesterTwoPage(),
                          ));
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Semester One', 'Semester Two'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  MyListTile(
                    icon: Icons.person,
                    text: " S E T T I N G S ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
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
