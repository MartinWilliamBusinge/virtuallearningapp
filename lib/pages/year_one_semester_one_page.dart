import 'package:flutter/material.dart';
import 'package:virtuallearningapp/course_pages/communication_skills_page.dart';
import 'package:virtuallearningapp/course_pages/computer_architecture_page.dart';
import 'package:virtuallearningapp/course_pages/opp_page.dart';

class YearOneSemesterOnePage extends StatelessWidget {
  const YearOneSemesterOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SEMESTER ONE", style: TextStyle(color: Color.fromARGB(255, 247, 245, 245)))),
        backgroundColor: const Color.fromARGB(255, 159, 47, 173),
      ),
      backgroundColor: const Color.fromARGB(255, 238, 240, 240),
      body: ListView(
        children: [
          ListTile(
            title: const Text('OBJECT-ORIENTED PROGRAMMING', style: TextStyle(color: Colors.red)),
            subtitle: const Text('COURSE CODE: CSC1102', style: TextStyle(color: Color.fromARGB(255, 44, 43, 43))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OOPPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('COMPUTER ARCHITECTURE', style: TextStyle(color: Colors.red)),
            subtitle: const Text('COURSE CODE: CSC1103', style: TextStyle(color: Color.fromARGB(255, 49, 48, 48))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComputerArchitecturePage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('COMMUNICATION SKILLS', style: TextStyle(color: Colors.red)),
            subtitle: const Text('COURSE CODE: CSK1101', style: TextStyle(color: Color.fromARGB(255, 24, 23, 23))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommunicationSkillsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
