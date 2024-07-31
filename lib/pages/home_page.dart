import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:virtuallearningapp/components/drawer.dart';
import 'package:virtuallearningapp/components/settings.dart';
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
  int _currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;
  late PageController _pageController;

  final List<Widget> _pages = [
    const UserHomePage(),
    const ChatPage(),
    const GeminiChatPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToAccountPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AccountPage(),
    ));
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 245, 248),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 159, 47, 173),
        elevation: 0,
        title: const Text("VIRTUAL LEARNING APP"),
        actions: [
          IconButton(
            onPressed: _navigateToAccountPage,
            icon: const Icon(Icons.person_2_outlined),
            padding: const EdgeInsets.all(10.0),
            color: Colors.green,
            iconSize: 40, // Set the color of the icon
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 159, 47, 173),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white,
            color: const Color.fromARGB(255, 159, 47, 173),
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 153, 104, 151),
            padding: const EdgeInsets.all(16),
            onTabChange: _onTabChange,
            selectedIndex: _currentIndex,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.message, text: "Chat"),
              GButton(icon: Icons.wechat_rounded, text: "Chat Bot"),
              GButton(icon: Icons.settings, text: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}
