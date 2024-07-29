// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/components/my_list_tile.dart';
import 'package:virtuallearningapp/components/settings.dart';
import 'package:virtuallearningapp/pages/downloads_page.dart';
import 'package:virtuallearningapp/pages/home_page.dart';
import 'package:virtuallearningapp/pages/year_one_semester_one_page.dart';
import 'package:virtuallearningapp/pages/year_one_semester_two_page.dart';
import 'package:virtuallearningapp/pages/year_two_semester_one_page.dart';
import 'package:virtuallearningapp/pages/year_two_semester_two_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isYearOneExpanded = false;
  bool _isYearTwoExpanded = false;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: (Color.fromARGB(255, 245, 243, 244)),
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "       “REMEMBER\"\n Being a student is easy.\nLearning requires actual work.” \n     *William Crawford*",
                  style: GoogleFonts.bonaNova(
                    textStyle:
                        TextStyle(fontSize: 18, color: Color.fromARGB(255, 146, 80, 167), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            //Home button
            Expanded(
              child: ListView(
                children: [
                  MyListTile(
                    icon: Icons.home,
                    text: 'H O M E', 
                    
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                    },
                  ),

                  //Year One Button with popup menu
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    color: _isYearOneExpanded
                        ? Colors.deepPurple.shade300
                        : Colors.transparent,
                    child: ListTile(
                      leading: const Icon(
                        Icons.looks_one_rounded,
                        color: Color.fromARGB(255, 141, 50, 95),
                      ),
                      title: Text(
                        "Y E A R  O N E",
                        style: GoogleFonts.ptSerif(
                          textStyle: const TextStyle(color: Color.fromARGB(255, 160, 69, 137)),
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Semester One') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const YearOneSemesterOnePage(),
                            ));
                          } else if (value == 'Semester Two') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const YearOneSemesterTwoPage(),
                            ));
                          }
                        },
                        onCanceled: () {
                          setState(() {
                            _isYearOneExpanded = false;
                          });
                        },
                        onOpened: () {
                          setState(() {
                            _isYearOneExpanded = true;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Semester One', 'Semester Two'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),

                  //Year Two Button with popup menu
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    color: _isYearTwoExpanded
                        ? Colors.deepPurple.shade300
                        : Colors.transparent,
                    child: ListTile(
                      leading: const Icon(
                        Icons.looks_two_rounded,
                        color: Color.fromARGB(255, 146, 66, 139),
                      ),
                      title: Text(
                        "Y E A R  T W O ",
                        style: GoogleFonts.ptSerif(
                          textStyle: const TextStyle(color: Color.fromARGB(255, 129, 55, 96)),
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Semester One') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const YearTwoSemesterOnePage(),
                            ));
                          } else if (value == 'Semester Two') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const YearTwoSemesterTwoPage(),
                            ));
                          }
                        },
                        onCanceled: () {
                          setState(() {
                            _isYearTwoExpanded = false;
                          });
                        },
                        onOpened: () {
                          setState(() {
                            _isYearTwoExpanded = true;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Semester One', 'Semester Two'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),

                  //Downloads button
                  MyListTile(
                    icon: Icons.download_rounded,
                    text: "D O W N L O A D S ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DownloadPage(),
                      ));
                    },
                  ),

                  //Setting button
                  MyListTile(
                    icon: Icons.settings,
                    text: " S E T T I N G S ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  const SettingsPage(),
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
