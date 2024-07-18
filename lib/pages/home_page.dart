import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/components/settings.dart';
import 'package:virtuallearningapp/pages/downloads_page.dart';
import 'package:virtuallearningapp/pages/chat_page.dart';
import 'package:virtuallearningapp/pages/profile_page.dart';
import 'package:virtuallearningapp/pages/user_home.dart';
import 'package:virtuallearningapp/pages/year_one.dart';
import 'package:virtuallearningapp/pages/year_two.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final List<Widget> _pages = [
    const UserHomePage(),
    const ChatPage(),
    const SettingsPage(),
    const ProfilePage(),
  ];

  int _selectedIndex = 0;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 61, 37, 102),
        elevation: 0,
        title:
            const Text("     V I R T U A L       L E A R N I N G       A P P"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Colors.green, // Set the color of the icon
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 78, 59, 114),
          child: ListView(
            children:  [
              const DrawerHeader(
                child: Center(
                    child: Text(
                  "W E L C O M E",
                  style: TextStyle(fontSize: 25),
                )),
              ),
              ListTile(
                leading: const Icon(Icons.one_k),
                title: const Text(
                  "DOWNLOADS ",
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DownloadPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.first_page),
                title: const Text(
                  "Y E A R  O N E  ",
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const YearOnePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.one_k),
                title: const Text(
                  "Y E A R  T W O ",
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const YearTwoPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
