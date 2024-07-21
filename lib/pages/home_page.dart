import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtuallearningapp/components/drawer.dart';
import 'package:virtuallearningapp/components/settings.dart';
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
  final user = FirebaseAuth.instance.currentUser!;

  final List<Widget> _pages = [
    const UserHomePage(),
     ChatPage(),
    const SettingsPage(),
    const GeminiChatPage(),
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
            const Text("V I R T U A L  L E A R N I N G  A P P"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Colors.green, // Set the color of the icon
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.wechat_rounded), label: "Chat GPT"),
        ],
      ),
    );
  }
}
