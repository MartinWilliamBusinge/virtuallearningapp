import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:virtuallearningapp/components/drawer.dart';
import 'package:virtuallearningapp/pages/account_page.dart';
import 'package:virtuallearningapp/pages/chat_page.dart';
import 'package:virtuallearningapp/pages/gemini_chat_page.dart';
import 'package:virtuallearningapp/pages/user_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final user = FirebaseAuth.instance.currentUser!;

  final List<Widget> _pages = [
    const UserHomePage(),
    ChatPage(),
    const AccountPage(),
    const GeminiChatPage(),
  ];

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _navigateBottomBar(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 61, 37, 102),
        elevation: 0,
        title: const Text("VIRTUAL LEARNING APP"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Colors.green, // Set the color of the icon
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pages[index],
      bottomNavigationBar: Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.deepPurple,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(16),
            onTabChange: _navigateBottomBar,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.message, text: "Chat"),
              GButton(icon: Icons.person, text: "Profile"),
              GButton(icon: Icons.wechat_rounded, text: "Chat Bot"),
            ],
          ),
        ),
      ),
    );
  }
}
